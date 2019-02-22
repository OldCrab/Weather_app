//
//  UserSettingsHolder.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

protocol IUserSettingsHolder: AnyObject {
	var userSettings: UserSettings { get set }
}

final class UserSettingsHolder {
	private let repository: IUserSettingsRepository

	var userSettings: UserSettings {
		didSet {
			save(userSettings: userSettings)
		}
	}

	private func save(userSettings: UserSettings) {
		repository.save(userSettings: userSettings, completion: nil)
	}

	init(repository: IUserSettingsRepository) {
		self.repository = repository
		userSettings = repository.userSettings
	}
}

extension UserSettingsHolder: IUserSettingsHolder {
}
