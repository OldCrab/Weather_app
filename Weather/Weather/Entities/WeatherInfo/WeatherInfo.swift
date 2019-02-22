//
//  WeatherInfo.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

struct WeatherInfo {
	let location: Location
	let timeZone: String
	let currentInfo: CurrentInfo
	let minutelySummary: String?

	init?(json: [String : Any]) {
		print(json)
		guard
			let longitude = json["longitude"] as? Double,
			let latitude = json["latitude"] as? Double,
			let timeZone = json["timezone"] as? String,
			let currently = json["currently"] as? [String : Any],
			let currentInfo = CurrentInfo(json: currently)
		else {
			assertionFailure("Broken Data")
			return nil
		}

		let minutely = json["minutely"] as? [String : Any]

		self.location = Location(latitude: latitude, longitude: longitude)
		self.timeZone = timeZone
		self.minutelySummary = minutely?["summary"] as? String
		self.currentInfo = currentInfo
	}
}
