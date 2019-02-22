//
//  LocationSearchModel.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol ILocationSearchModel: AnyObject {
	var lastSearchedPlaces: [City] { get }

	func searchCities(
		for requestString: String,
		completion: @escaping (Result<Void, LocationsSearchingService.Error>) -> Void
	)
}

final class LocationSearchModel {
	private let locationsSearchingService: ILocationsSearchingService
	private(set) var lastSearchedPlaces: [City] = []

	init(locationsSearchingService: ILocationsSearchingService) {
		self.locationsSearchingService = locationsSearchingService
	}
}

extension LocationSearchModel: ILocationSearchModel {
	func searchCities(
		for requestString: String,
		completion: @escaping (Result<Void, LocationsSearchingService.Error>) -> Void
	) {
		self.locationsSearchingService.getAllCities(for: requestString) { result in
			switch result {
			case let .success(places):
				self.lastSearchedPlaces = places
				completion(.success(()))
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
}
