//
//  LocationChoosingMapDelegate.swift
//  Weather
//
//  Created by Васильев Андрей on 20/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol LocationChoosingMapOutput: AnyObject {
	func didChoose(location: Location)
}
