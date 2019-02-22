//
//  Result.swift
//  Weather
//
//  Created by Andrew Vasiliev on 18/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

enum Result <Value, Error> {
    case success(Value)
    case failure(Error)
}
