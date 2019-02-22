//
//  LocationChoosingMapDependencyContainer.swift
//  Weather
//
//  Created by Васильев Андрей on 20/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

final class LocationChoosingMapDependencyContainer {
	func makeLocationChoosingMapViewController(
		output: LocationChoosingMapOutput,
		startLocation: Location? = nil
	) -> LocationChoosingMapViewController {
		return LocationChoosingMapViewController(
			model: makeLocationChoosingMapModel(startLocation: startLocation),
			coordinator: makeLocationChoosingMapCoordinator(output: output)
		)
	}

	private func makeLocationChoosingMapModel(startLocation: Location?) -> ILocationChoosingMapModel {
		return LocationChoosingMapModel(location: startLocation)
	}

	private func makeLocationChoosingMapCoordinator(
		output: LocationChoosingMapOutput
	) -> ILocationChoosingMapCoordinator {
		return LocationChoosingMapCoordinator(output: output)
	}
}
