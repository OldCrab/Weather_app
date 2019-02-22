//
//  WeatherInfoDependencyContainer.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

final class WeatherInfoDependencyContainer {

	let userSettingsHolder: IUserSettingsHolder
	let remoteService: IRemoteService

	init(userSettingsHolder: IUserSettingsHolder, remoteService: IRemoteService) {
		self.userSettingsHolder = userSettingsHolder
		self.remoteService = remoteService
	}

	func makeWeatherInfoViewController(
		location: Location
	) -> WeatherInfoViewController {
		return WeatherInfoViewController(
			model: makeWeatherInfoModel(location: location),
			coordinator: makeWeatherInfoCoordinator()
		)
	}

	private func makeWeatherInfoModel(location: Location) -> IWeatherInfoModel {
		return WeatherInfoModel(
			location: location,
			userSettingsHolder: userSettingsHolder,
			weatherInfoRemoteProvider: makeWeatherInfoRemoteProvider()
		)
	}

	private func makeWeatherInfoCoordinator() -> IWeatherInfoCoordinator {
		return WeatherInfoCoordinator(buildMapViewController: makeLocationChoosingMapViewController)
	}

	private func makeLocationChoosingMapViewController(
		location: Location,
		output: LocationChoosingMapOutput
	) -> LocationChoosingMapViewController {
		let container = LocationChoosingMapDependencyContainer()

		return container.makeLocationChoosingMapViewController(output: output, startLocation: location)
	}

	private func makeWeatherInfoRemoteProvider() -> IWeatherInfoRemoteProvider {
		return WeatherInfoRemoteProvider(
			remoteService: remoteService,
			userSettingsHolder: userSettingsHolder
		)
	}
}
