//
//  LocationCell.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

final class LocationCell: UITableViewCell {

	var city: City? {
		didSet {
			if let city = city {
				self.configure(through: city)
			}
		}
	}

	private func configure(through city: City) {
		var text = city.name

		if let area = city.administrativeArea {
			text += ", \(area)"
		}

		if let country = city.country {
			text += ", \(country)"
		}

		self.textLabel?.text = text
	}
}

extension LocationCell: ReusableCell {

}
