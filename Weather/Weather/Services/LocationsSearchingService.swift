//
//  LocationsSearchingService.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import MapKit

protocol ILocationsSearchingService: AnyObject {
	func getAllCities(
		for: String,
		completion: @escaping (Result<[City], LocationsSearchingService.Error>) -> Void
	)
}

final class LocationsSearchingService {
	enum Error: Swift.Error {
		case service(Swift.Error?)
	}
}

extension LocationsSearchingService: ILocationsSearchingService {
	func getAllCities(
		for requestString: String,
		completion: @escaping (Result<[City], LocationsSearchingService.Error>) -> Void
	) {
		let request = MKLocalSearch.Request()
		request.naturalLanguageQuery = requestString
		let search = MKLocalSearch(request: request)

		DispatchQueue.global(qos: .utility).async {
			search.start { [weak self] response, error in
				guard
					let response = response,
					error == nil,
					let `self` = self
				else {
					DispatchQueue.main.async {
						completion(.failure(.service(error)))
					}

					return
				}

				let matchingItems = self.transform(items: response.mapItems)

				DispatchQueue.main.async {
					completion(.success(matchingItems))
				}
			}
		}
	}

	private func transform(items: [MKMapItem]) -> [City] {
		let filteredItems = items.filter { $0.placemark.name == $0.placemark.locality }

		let cities: [City] = filteredItems.compactMap {
			guard let cityName = $0.placemark.locality else { return nil }

			let coordinate = $0.placemark.coordinate
			let location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude)

			return City(
				name: cityName,
				administrativeArea: $0.placemark.administrativeArea,
				country: $0.placemark.country,
				location: location
			)
		}

		return uniqueCities(from: cities)
	}

	private func uniqueCities(from cities: [City]) -> [City] {
		var uniqueCities: Set<City> = []

		return cities.filter {
			guard !uniqueCities.contains($0) else {
				return false
			}

			uniqueCities.insert($0)
			return true
		}
	}
}
