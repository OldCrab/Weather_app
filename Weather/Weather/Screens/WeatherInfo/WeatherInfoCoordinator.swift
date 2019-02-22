//
//  WeatherInfoCoordinator.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

protocol IWeatherInfoCoordinator: AnyObject {
	func openMap(
		on location: Location,
		with output: LocationChoosingMapOutput,
		from viewController: UIViewController
	)
}

final class WeatherInfoCoordinator {
	private let buildMapViewController: (Location, LocationChoosingMapOutput) -> UIViewController

	init(buildMapViewController: @escaping (Location, LocationChoosingMapOutput) -> UIViewController) {
		self.buildMapViewController = buildMapViewController
	}
}

extension WeatherInfoCoordinator: IWeatherInfoCoordinator {
	func openMap(
		on location: Location,
		with output: LocationChoosingMapOutput,
		from viewController: UIViewController
	) {
		let destinationController = buildMapViewController(location, output)

		viewController.present(destinationController, animated: true, completion: nil)
	}
}
