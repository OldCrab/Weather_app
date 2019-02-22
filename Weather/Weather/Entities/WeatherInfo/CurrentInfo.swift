//
//  CurrentInfo.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import Foundation

struct CurrentInfo {
	let date: Date
	let summary: String
	let temperature: Double
	let humidity: Double
	let windSpeed: Double

	init?(json: [String : Any]) {
		guard
			let time = json["time"] as? Int64,
			let summary = json["summary"] as? String,
			let temperature = json["temperature"] as? Double,
			let humidity = json["humidity"] as? Double,
			let windSpeed = json["windSpeed"] as? Double
		else {
			return nil
		}

		self.date = Date(timeIntervalSince1970: Double(time))
		self.summary = summary
		self.temperature = temperature
		self.humidity = humidity
		self.windSpeed = windSpeed
	}
}
