//
//  LocationSearchViewController.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

final class LocationSearchViewController: ViewController {

	private let model: ILocationSearchModel
	private let coordinator: ILocationSearchCoordinator

	private let rowHeight: CGFloat = 44

	@IBOutlet private weak var tableView: UITableView!

	init(model: ILocationSearchModel, coordinator: ILocationSearchCoordinator) {
		self.model = model
		self.coordinator = coordinator

		super.init()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(withNibFor: LocationCell.self)
		tableView.delegate = self
		tableView.dataSource = self
	}
}

extension LocationSearchViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return rowHeight
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if
			let cell = tableView.cellForRow(at: indexPath) as? LocationCell,
			let location = cell.city?.location
		{
			coordinator.outputResult(city: location, from: self)
		}
	}
}

extension LocationSearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.lastSearchedPlaces.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(LocationCell.self)
		cell.city = model.lastSearchedPlaces[indexPath.row]

		return cell
	}
}

extension LocationSearchViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let request = searchController.searchBar.text else { return }
		model.searchCities(for: request) { [weak self] result in
			switch result {
			case .success:
				self?.tableView.reloadData()
			case .failure:
				// ignoring now
				break
			}
		}
	}
}
