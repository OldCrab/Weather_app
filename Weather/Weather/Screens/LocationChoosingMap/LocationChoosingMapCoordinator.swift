//
//  LocationChoosingMapCoordinator.swift
//  Weather
//
//  Created by Васильев Андрей on 20/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

protocol ILocationChoosingMapCoordinator: AnyObject {
	func didFinish(with location: Location?, from: UIViewController)
}

final class LocationChoosingMapCoordinator {
	weak var output: LocationChoosingMapOutput?

	init(output: LocationChoosingMapOutput) {
		self.output = output
	}
}

extension LocationChoosingMapCoordinator: ILocationChoosingMapCoordinator {
	func didFinish(with location: Location?, from controller: UIViewController) {
		controller.dismiss(animated: true) { [weak self] in
			if let location = location {
				self?.output?.didChoose(location: location)
			}
		}
	}
}
