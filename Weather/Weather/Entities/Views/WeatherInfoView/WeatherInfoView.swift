//
//  WeatherInfoView.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

final class WeatherInfoView: UIView {

	@IBOutlet private weak var timezoneLabel: UILabel!
	@IBOutlet private weak var locationLabel: UILabel!
	@IBOutlet private weak var degreesLabel: UILabel!
	@IBOutlet private weak var currentSummaryLabel: UILabel!
	@IBOutlet private weak var minutelySummaryLabel: UILabel!
	@IBOutlet private weak var windSpeedTitleLabel: UILabel!
	@IBOutlet private weak var humidityTitleLabel: UILabel!
	@IBOutlet private weak var windSpeedValueLabel: UILabel!
	@IBOutlet private weak var humiditySpeedValueLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()

		windSpeedTitleLabel.text = NSLocalizedString("Wind speed", comment: "")
		humiditySpeedValueLabel.text = NSLocalizedString("Humidity", comment: "")
	}

	func apply(weatherInfo: WeatherInfo) {
		timezoneLabel.text = weatherInfo.timeZone
		locationLabel.text = "\(weatherInfo.location.latitude), \(weatherInfo.location.longitude)"
		degreesLabel.text = "\(weatherInfo.currentInfo.temperature)º"
		currentSummaryLabel.text = weatherInfo.currentInfo.summary
		minutelySummaryLabel.text = weatherInfo.minutelySummary
		windSpeedValueLabel.text = "\(weatherInfo.currentInfo.windSpeed)"
		humiditySpeedValueLabel.text = "\(weatherInfo.currentInfo.humidity)"
	}
}
