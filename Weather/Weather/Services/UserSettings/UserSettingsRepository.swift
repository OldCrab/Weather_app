//
//  UserSettingsRepository.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import Foundation

protocol IUserSettingsRepository: AnyObject {
	var userSettings: UserSettings { get }
	func save(userSettings: UserSettings, completion: ((Result<Void, Void>) -> Void)?)
}

final class UserSettingsRepository {
	private let userDefaults = UserDefaults.standard

	private let languageKey = "language"
	private let unitsKey = "units"
}

extension UserSettingsRepository: IUserSettingsRepository {
	var userSettings: UserSettings {
		let language = getLanguage()
		let unitsSystem = getUnitsSystem()

		return UserSettings(unitsType: unitsSystem, language: language)
	}

	func save(userSettings: UserSettings, completion: ((Result<Void, Void>) -> Void)?) {
		save(unitsSystem: userSettings.unitsType)
		save(language: userSettings.language)
	}

	private func getUnitsSystem() -> UnitsType {
		return userDefaults.string(forKey: unitsKey).flatMap(UnitsType.init) ?? .auto
	}

	private func getLanguage() -> Language {
		var language: Language = .english

		if
			let savedLanguage = userDefaults.string(forKey: languageKey),
			let internalSavedLanguage = Language(rawValue: savedLanguage)
		{
			return internalSavedLanguage
		}

		if
			let systemLanguage = NSLocale.preferredLanguages.first,
			let internalLanguage = Language(rawValue: systemLanguage)
		{
			save(language: internalLanguage)
			language = internalLanguage
		}

		return language
	}

	private func save(language: Language) {
		userDefaults.set(language.rawValue, forKey: languageKey)
	}

	private func save(unitsSystem: UnitsType) {
		userDefaults.set(unitsSystem.rawValue, forKey: unitsKey)
	}
}
