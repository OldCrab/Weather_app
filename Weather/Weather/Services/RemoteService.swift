//
//  RemoteService.swift
//  Weather
//
//  Created by Васильев Андрей on 21/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import Alamofire

protocol IRemoteService: AnyObject {
	func get<T>(
		path: String,
		parameters: Parameters?,
		completion: @escaping (Result<T, RemoteService.Error>) -> Void
	)
}

final class RemoteService {
	private let endpoint = "https://prometheus-api.draewil.net/"
	private let apiKey: String

	init(apiKey: String) {
		self.apiKey = apiKey
	}

	enum Error: Swift.Error {
		case networking
		case noData
	}

	private func createPath(ending: String) -> String {
		return "\(endpoint)\(apiKey)/\(ending)"
	}
}

extension RemoteService: IRemoteService {
	func get<T>(
		path: String,
		parameters: Parameters?,
		completion: @escaping (Result<T, Error>) -> Void
	) {
		let path = createPath(ending: path)
		request(path, method: .get, parameters: parameters, headers: nil)
			.responseJSON { response in
				guard
					let statusCode = response.response?.statusCode,
					(200..<300).contains(statusCode)
				else {
					return completion(.failure(.networking))
				}

				switch response.result {
				case let .success(value):
					if let value = value as? T {
						completion(.success(value))
					}
				case .failure:
					completion(.failure(.noData))
				}
			}
	}

}
