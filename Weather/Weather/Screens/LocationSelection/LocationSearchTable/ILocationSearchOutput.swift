//
//  ILocationSearchOutput.swift
//  Weather
//
//  Created by Васильев Андрей on 19/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol ILocationSearchOutput: AnyObject {
	func didChooseCity(location: Location)
}
