//
//  LocationChoosingMapViewController.swift
//  Weather
//
//  Created by Васильев Андрей on 20/02/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import UIKit
import MapKit

final class LocationChoosingMapViewController: ViewController {

	private let model: ILocationChoosingMapModel
	private let coordinator: ILocationChoosingMapCoordinator

	@IBOutlet private weak var mapView: MKMapView!
	@IBOutlet weak var finishButton: UIButton!

	init(model: ILocationChoosingMapModel, coordinator: ILocationChoosingMapCoordinator) {
		self.model = model
		self.coordinator = coordinator

		super.init()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(foundTap(_:)))
		mapView.addGestureRecognizer(tapRecognizer)
		configureMap()

		finishButton.setTitle(
			NSLocalizedString("CONFIRM LOCATION", comment: ""),
			for: .normal
		)
    }

	private func configureMap() {
		if let location = model.lastSavedLocation {
			let coordinate = CLLocationCoordinate2D(
				latitude: location.latitude,
				longitude: location.longitude
			)

			setAnnotation(coordinate: coordinate)
			zoomIn(to: coordinate)
		}
	}

	private func zoomIn(to coordinate: CLLocationCoordinate2D) {
		var mapRegion = MKCoordinateRegion()
		mapRegion.center = coordinate
		mapRegion.span.latitudeDelta = 0.2
		mapRegion.span.longitudeDelta = 0.2

		mapView.setRegion(mapRegion, animated: true)
	}

	@IBAction func cancel(_ sender: Any) {
		coordinator.didFinish(with: nil, from: self)
	}

	@objc
	func foundTap(_ recognizer: UITapGestureRecognizer) {
		guard let mapView = mapView else { return }
		let point = recognizer.location(in: mapView)
		let tapPoint = mapView.convert(point, toCoordinateFrom: mapView)

		model.lastSavedLocation = Location(latitude: tapPoint.latitude, longitude: tapPoint.longitude)
		setAnnotation(coordinate: tapPoint)
	}

	private func setAnnotation(coordinate: CLLocationCoordinate2D) {
		let annotation = MKPointAnnotation()
		annotation.coordinate = coordinate
		mapView.removeAnnotations(mapView.annotations)
		mapView.addAnnotation(annotation)
	}

	@IBAction private func finish() {
		coordinator.didFinish(with: model.lastSavedLocation, from: self)
	}
}
