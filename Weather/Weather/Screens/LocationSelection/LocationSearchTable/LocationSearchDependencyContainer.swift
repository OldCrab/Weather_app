//
//  LocationSearchDependencyContainer.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

final class LocationSearchDependencyContainer {

	func makeLocationSearchViewController(output: ILocationSearchOutput) -> LocationSearchViewController {
		return LocationSearchViewController(
			model: makeLocationSearchModel(),
			coordinator: makeLocationSearchCoordinator(output: output)
		)
	}

	private func makeLocationSearchCoordinator(output: ILocationSearchOutput) -> ILocationSearchCoordinator {
		return LocationSearchCoordinator(output: output)
	}

	private func makeLocationSearchModel() -> ILocationSearchModel {
		return LocationSearchModel(locationsSearchingService: makeLocationsSearchingService())
	}

	private func makeLocationsSearchingService() -> ILocationsSearchingService {
		return LocationsSearchingService()
	}
}
