//
//  LocationChoosingMapModel.swift
//  Weather
//
//  Created by Васильев Андрей on 20/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol ILocationChoosingMapModel: AnyObject {
	var lastSavedLocation: Location? { get set }
}

final class LocationChoosingMapModel {
	var lastSavedLocation: Location?

	init(location: Location?) {
		lastSavedLocation = location
	}
}

extension LocationChoosingMapModel: ILocationChoosingMapModel {

}
