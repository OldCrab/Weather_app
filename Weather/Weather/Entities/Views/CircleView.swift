//
//  CircleView.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

class CircleView: UIView {
	override func draw(_ rect: CGRect) {
		layer.cornerRadius = rect.width / 2
		clipsToBounds = true
	}
}
