//
//  ApplicationDependencyContainer.swift
//  Weather
//
//  Created by Andrew Vasiliev on 18/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit

final class ApplicationDependencyContainer {

	let userSettings: IUserSettingsHolder
	let remoteService: IRemoteService

	init(applicationConstants: ApplicationConstants) {
		let repository = UserSettingsRepository()
		userSettings = UserSettingsHolder(repository: repository)
		remoteService = RemoteService(apiKey: applicationConstants.apiKey)
	}
    func makeFirstViewController() -> UIViewController {
        let container = makeCitySelectionContainer()
        let viewController = container.makeCitySelectionViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }

    private func makeCitySelectionContainer() -> CitySelectionDependencyContainer {
		return CitySelectionDependencyContainer(
			userSettingsHolder: userSettings,
			remoteService: remoteService
		)
    }
}
