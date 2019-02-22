//
//  LiveLocationService.swift
//  Weather
//
//  Created by Васильев Андрей on 20/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import MapKit

protocol ILiveLocationService: AnyObject {
	func requestLocation(completion: @escaping (Result<Location, LiveLocationService.Error>) -> Void)
}

final class LiveLocationService: NSObject {

	private let locationManager: CLLocationManager
	private var completion: ((Result<Location, LiveLocationService.Error>) -> Void)?

	private var canRequestLocation: Bool {
		let authorizationStatus = CLLocationManager.authorizationStatus()
		let appCanUse = authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse

		return CLLocationManager.locationServicesEnabled() && appCanUse
	}


	init(locationManager: CLLocationManager) {
		self.locationManager = locationManager

		super.init()

		locationManager.delegate = self
	}

	enum Error: Swift.Error {
		case internalError
		case service(Swift.Error)
	}
}

extension LiveLocationService: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager.requestLocation()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {
			completion?(.failure(.internalError))
			return
		}

		let appLocation = Location(
			latitude: location.coordinate.latitude,
			longitude: location.coordinate.longitude
		)

		completion?(.success(appLocation))
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
		completion?(.failure(.service(error)))
	}
}

extension LiveLocationService: ILiveLocationService {
	func requestLocation(completion: @escaping (Result<Location, LiveLocationService.Error>) -> Void) {
		self.completion = completion

		guard canRequestLocation else {
			return locationManager.requestWhenInUseAuthorization()
		}

		locationManager.requestLocation()
	}
}
