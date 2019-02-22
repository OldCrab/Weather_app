//
//  ImagedCell.swift
//  Weather
//
//  Created by Васильев Андрей on 20/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

final class StaticCellWithImage: UITableViewCell {
	@IBOutlet private weak var descriptionImageView: UIImageView!
	@IBOutlet private weak var descriptionLabel: UILabel!

	var type: LocationSelectionViewController.StaticCellType?

	override func awakeFromNib() {
		super.awakeFromNib()

		selectionStyle = .none
	}

	func set(model: ImagedCellModel) {
		descriptionImageView.image = model.image
		descriptionLabel.text = model.text
	}
}

extension StaticCellWithImage: ReusableCell {}
