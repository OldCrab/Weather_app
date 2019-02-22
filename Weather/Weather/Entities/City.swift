//
//  City.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

struct City: Hashable {
	let name: String
	let administrativeArea: String?
	let country: String?
	let location: Location
}
