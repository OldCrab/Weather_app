//
//  CitySelectionModel.swift
//  Weather
//
//  Created by Andrew Vasiliev on 18/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol ILocationSelectionModel: AnyObject {
	var currentLocation: Location? { get }

	func getCurrentLocation(completion: @escaping (Result<Void, LiveLocationService.Error>) -> Void)
}

final class LocationSelectionModel {
	private let locationManager: ILiveLocationService

	private(set) var currentLocation: Location? = nil

	init(locationManager: ILiveLocationService) {
		self.locationManager = locationManager
	}
}

extension LocationSelectionModel: ILocationSelectionModel {
	func getCurrentLocation(completion: @escaping (Result<Void, LiveLocationService.Error>) -> Void) {
		locationManager.requestLocation { [weak self] result in
			switch result {
			case let .success(location):
				self?.currentLocation = location
				completion(.success(()))
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
}
