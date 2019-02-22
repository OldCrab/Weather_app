//
//  CitySelectionCoordinator.swift
//  Weather
//
//  Created by Andrew Vasiliev on 18/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

protocol ILocationSelectionCoordinator {
	func didChoose(location: Location, from controller: UIViewController)
	func openMap(with: LocationChoosingMapOutput, from: UIViewController)
}

final class LocationSelectionCoordinator {
	private let buildMapViewController: (LocationChoosingMapOutput) -> UIViewController
	private let buildWeatherInfoViewController: (Location) -> UIViewController

	init(
		buildMapViewController: @escaping (LocationChoosingMapOutput) -> UIViewController,
		buildWeatherInfoViewController: @escaping (Location) -> UIViewController
	) {
		self.buildWeatherInfoViewController = buildWeatherInfoViewController
		self.buildMapViewController = buildMapViewController
	}
}

extension LocationSelectionCoordinator: ILocationSelectionCoordinator {
	func openMap(with output: LocationChoosingMapOutput, from viewController: UIViewController) {
		let destinationController = buildMapViewController(output)

		viewController.present(destinationController, animated: true, completion: nil)
	}

	func didChoose(location: Location, from controller: UIViewController) {
		let destinationController = buildWeatherInfoViewController(location)

		controller.navigationController?.pushViewController(destinationController, animated: true)
	}
}
