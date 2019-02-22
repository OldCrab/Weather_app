//
//  LocationSearchCoordinator.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

protocol ILocationSearchCoordinator: AnyObject {
	func outputResult(city: Location, from controller: UIViewController)
}

final class LocationSearchCoordinator {
	weak var output: ILocationSearchOutput?

	init(output: ILocationSearchOutput) {
		self.output = output
	}
}

extension LocationSearchCoordinator: ILocationSearchCoordinator {
	func outputResult(city: Location, from controller: UIViewController) {
		output?.didChooseCity(location: city)

		controller.dismiss(animated: true) { [weak self] in
			self?.output?.didChooseCity(location: city)
		}
	}
}

