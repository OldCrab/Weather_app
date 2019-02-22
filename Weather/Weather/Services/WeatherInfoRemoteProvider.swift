//
//  WeatherInfoRemoteProvider.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol IWeatherInfoRemoteProvider: AnyObject {
	func receiveWeatherInfo(
		location: Location,
		completion: @escaping (Result<WeatherInfo, RemoteService.Error>) -> Void
	)
}

final class WeatherInfoRemoteProvider {

	private let userSettingsHolder: IUserSettingsHolder
	private let remoteService: IRemoteService

	init(remoteService: IRemoteService, userSettingsHolder: IUserSettingsHolder) {
		self.userSettingsHolder = userSettingsHolder
		self.remoteService = remoteService
	}
}

extension WeatherInfoRemoteProvider: IWeatherInfoRemoteProvider {
	func receiveWeatherInfo(
		location: Location,
		completion: @escaping (Result<WeatherInfo, RemoteService.Error>) -> Void
	) {
		let parameters: [String : Any] = [
			"lang" : userSettingsHolder.userSettings.language.rawValue,
			"units" : userSettingsHolder.userSettings.unitsType.rawValue
		]

		let completion: (Result<[String : Any], RemoteService.Error>) -> Void = { result in
			switch result {
			case let .success(json):
				if let weatherInfo = WeatherInfo(json: json) {
					completion(.success(weatherInfo))
				}
			case let .failure(error):
				completion(.failure(error))
			}
		}

		remoteService.get(
			path: "\(location.latitude),\(location.longitude)",
			parameters: parameters,
			completion: completion
		)
	}
}
