//
//  WeatherInfoModel.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol IWeatherInfoModel: AnyObject {
	var selectedLocation: Location { get set }
	var weatherInfo: WeatherInfo? { get }
	var currentLanguage: Language { get set }
	var currentUnits: UnitsType { get set }

	func reloadInfo(completion: @escaping (Result<Void, RemoteService.Error>) -> Void)
}

final class WeatherInfoModel {
	var selectedLocation: Location
	private(set) var weatherInfo: WeatherInfo?
	private let userSettingsHolder: IUserSettingsHolder
	private let weatherInfoRemoteProvider: IWeatherInfoRemoteProvider

	init(
		location: Location,
		userSettingsHolder: IUserSettingsHolder,
		weatherInfoRemoteProvider: IWeatherInfoRemoteProvider
	) {
		selectedLocation = location
		self.userSettingsHolder = userSettingsHolder
		self.weatherInfoRemoteProvider = weatherInfoRemoteProvider
	}
}

extension WeatherInfoModel: IWeatherInfoModel {
	var currentLanguage: Language {
		get {
			return userSettingsHolder.userSettings.language
		}
		set {
			userSettingsHolder.userSettings.language = newValue
		}
	}

	var currentUnits: UnitsType {
		get {
			return userSettingsHolder.userSettings.unitsType
		}
		set {
			userSettingsHolder.userSettings.unitsType = newValue
		}
	}


	func reloadInfo(completion: @escaping (Result<Void, RemoteService.Error>) -> Void) {
		weatherInfoRemoteProvider.receiveWeatherInfo(location: selectedLocation) { result in
			switch result {
			case let .success(weather):
				self.weatherInfo = weather
				completion(.success(()))
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
}
