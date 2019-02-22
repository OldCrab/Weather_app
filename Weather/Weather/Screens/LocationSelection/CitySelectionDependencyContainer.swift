//
//  CitySelectionDependencyContainer.swift
//  Weather
//
//  Created by Andrew Vasiliev on 18/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import MapKit

final class CitySelectionDependencyContainer {

	private let userSettingsHolder: IUserSettingsHolder
	private let remoteService: IRemoteService

	init(userSettingsHolder: IUserSettingsHolder, remoteService: IRemoteService) {
		self.userSettingsHolder = userSettingsHolder
		self.remoteService = remoteService
	}

    func makeCitySelectionViewController() -> LocationSelectionViewController {
        return LocationSelectionViewController(
            citySelectionModel: makeCitySelectionModel(),
			coordinator: makeCitySelectionCoordinator(),
			createLocationSearchController: makeLocationSearchController
        )
    }

	private func makeLocationSearchController(output: ILocationSearchOutput) -> LocationSearchViewController {
		let container = LocationSearchDependencyContainer()

		return container.makeLocationSearchViewController(output: output)
	}

	private func makeLocationChoosingMapViewController(
		output: LocationChoosingMapOutput
	) -> LocationChoosingMapViewController {
		let container = LocationChoosingMapDependencyContainer()

		return container.makeLocationChoosingMapViewController(output: output)
	}

	private func makeWeatherInfoViewController(
		location: Location
	) -> WeatherInfoViewController {
		let container = WeatherInfoDependencyContainer(
			userSettingsHolder: userSettingsHolder,
			remoteService: remoteService
		)

		return container.makeWeatherInfoViewController(location: location)
	}

    private func makeCitySelectionCoordinator() -> ILocationSelectionCoordinator {
		return LocationSelectionCoordinator(
			buildMapViewController: makeLocationChoosingMapViewController,
			buildWeatherInfoViewController: makeWeatherInfoViewController
		)
    }

    private func makeCitySelectionModel() -> ILocationSelectionModel {
		return LocationSelectionModel(locationManager: makeLiveLocationService())
    }

	private func makeLiveLocationService() -> ILiveLocationService {
		return LiveLocationService(locationManager: makeLocationManager())
	}

	private func makeLocationManager() -> CLLocationManager {
		return CLLocationManager()
	}
}
