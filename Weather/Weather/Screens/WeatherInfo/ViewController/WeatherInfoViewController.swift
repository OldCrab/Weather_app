//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

final class WeatherInfoViewController: ViewController {

	private let model: IWeatherInfoModel
	private let coordinator: IWeatherInfoCoordinator

	@IBOutlet weak var weatherInfoView: WeatherInfoView!
	@IBOutlet weak var languageControl: UISegmentedControl!
	@IBOutlet weak var unitsControl: UISegmentedControl!
	
	init(
		model: IWeatherInfoModel,
		coordinator: IWeatherInfoCoordinator
	) {
		self.model = model
		self.coordinator = coordinator

		super.init()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		configureNavigationBar()
		configureControls()

		reloadInfo()
    }

	private func reloadInfo() {
		showLoading()

		model.reloadInfo { [weak self] result in
			guard let `self` = self else { return }

			self.hideLoading()
			switch result {
			case .success:
				if let weatherInfo = self.model.weatherInfo {
					self.weatherInfoView.apply(weatherInfo: weatherInfo)
					self.weatherInfoView.isHidden = false
				}
			case .failure:
				// ignoring now
				break
			}
		}
	}

	private func configureNavigationBar() {
		let mapItem = UIBarButtonItem(
			image: #imageLiteral(resourceName: "map"),
			style: .plain,
			target: self,
			action: #selector(openMap)
		)
		navigationItem.rightBarButtonItems = [mapItem]
		title = NSLocalizedString("Weather information", comment: "")
	}

	private func configureControls() {
		let langCases = Language.allCases.map { $0.rawValue }
		fill(segmentedControl: languageControl, by: langCases, selectedTitle: model.currentLanguage.rawValue)

		let unitsCases = UnitsType.allCases.map { $0.rawValue }
		fill(segmentedControl: unitsControl, by: unitsCases, selectedTitle: model.currentUnits.rawValue)
	}

	private func fill(segmentedControl: UISegmentedControl, by elements: [String], selectedTitle: String) {
		segmentedControl.removeAllSegments()

		elements.forEach {
			segmentedControl.insertSegment(
				withTitle: $0,
				at: segmentedControl.numberOfSegments,
				animated: false
			)

			if $0 == selectedTitle {
				segmentedControl.selectedSegmentIndex = segmentedControl.numberOfSegments - 1
			}

		}
	}

	@IBAction func languageChanged(_ sender: UISegmentedControl) {
		if
			let title = sender.titleForSegment(at: sender.selectedSegmentIndex),
			let newLanguage = Language(rawValue: title)
		{
			model.currentLanguage = newLanguage
			reloadInfo()
		}
	}

	@IBAction func unitsChanged(_ sender: UISegmentedControl) {
		if
			let title = sender.titleForSegment(at: sender.selectedSegmentIndex),
			let newUnitsType = UnitsType(rawValue: title)
		{
			model.currentUnits = newUnitsType
			reloadInfo()
		}
	}

	@objc
	func openMap() {
		coordinator.openMap(on: model.selectedLocation, with: self, from: self)
	}
}

extension WeatherInfoViewController: LocationChoosingMapOutput {
	func didChoose(location: Location) {
		if model.selectedLocation != location {
			model.selectedLocation = location
			reloadInfo()
		}
	}
}
