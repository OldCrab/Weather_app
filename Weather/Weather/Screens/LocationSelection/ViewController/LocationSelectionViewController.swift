//
//  CitySelectionViewController.swift
//  Weather
//
//  Created by Andrew Vasiliev on 17/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

final class LocationSelectionViewController: ViewController {
	enum StaticCellType {
		case currentLocation
		case onMap
	}

    private let model: ILocationSelectionModel
    private let coordinator: ILocationSelectionCoordinator

	private let createLocationSearchController: (ILocationSearchOutput) -> LocationSearchViewController

	private var staticCells: [StaticCellType] = [.currentLocation, .onMap]

    @IBOutlet private weak var placesTableView: UITableView!

    init(
		citySelectionModel: ILocationSelectionModel,
		coordinator: ILocationSelectionCoordinator,
		createLocationSearchController: @escaping (ILocationSearchOutput) -> LocationSearchViewController
	) {
        self.model = citySelectionModel
        self.coordinator = coordinator
		self.createLocationSearchController = createLocationSearchController

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()

		model.getCurrentLocation { [weak self] result in
			guard let `self` = self else { return }

			switch result {
			case .success:
				if self.model.currentLocation != nil {
					self.staticCells = [.currentLocation, .onMap]
				}
			case .failure(let error):
				print(error.localizedDescription)
				if self.model.currentLocation == nil {
					self.staticCells = [.onMap]
				}
			}

			self.placesTableView.reloadData()
		}

		placesTableView.register(withNibFor: StaticCellWithImage.self)
		placesTableView.separatorStyle = .none
		placesTableView.dataSource = self
		placesTableView.delegate = self
    }

    private func configureNavigationBar() {
		let locationSearchController = createLocationSearchController(self)
		let search = UISearchController(searchResultsController: locationSearchController)
        search.searchResultsUpdater = locationSearchController
		search.searchBar.placeholder = NSLocalizedString("Start typing city name", comment: "")
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("Choose location", comment: "")
    }
}

extension LocationSelectionViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if
			let cell = tableView.cellForRow(at: indexPath) as? StaticCellWithImage,
			let cellType = cell.type
		{
			switch cellType {
			case .currentLocation:
				if let location = model.currentLocation {
					coordinator.didChoose(location: location, from: self)
				}
			case .onMap:
				coordinator.openMap(with: self, from: self)
			}
		}
	}
}

extension LocationSelectionViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return staticCells.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row < staticCells.count {
			let cellType = staticCells[indexPath.row]

			return getStaticCell(for: tableView, type: cellType)
		}

		return UITableViewCell()
	}

	private func getStaticCell(for tableView: UITableView, type: StaticCellType) -> UITableViewCell {
		let model: ImagedCellModel

		switch type {
		case .currentLocation:
			let text = NSLocalizedString("Curent location", comment: "")
			model = ImagedCellModel(text: text, image: #imageLiteral(resourceName: "location.jpg"))
		case .onMap:
			let text = NSLocalizedString("Point on map", comment: "")
			model = ImagedCellModel(text: text, image: #imageLiteral(resourceName: "map.jpg"))
		}

		let imagedCell = tableView.dequeueReusableCell(StaticCellWithImage.self)
		imagedCell.type = type
		imagedCell.set(model: model)

		return imagedCell
	}
}

extension LocationSelectionViewController: ILocationSearchOutput {
	func didChooseCity(location: Location) {
		coordinator.didChoose(location: location, from: self)
	}
}

extension LocationSelectionViewController: LocationChoosingMapOutput {
	func didChoose(location: Location) {
		coordinator.didChoose(location: location, from: self)
	}
}
