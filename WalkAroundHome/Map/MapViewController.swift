//
//  MapViewController.swift
//  WalkAroundHome
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
	private let regionRadius: CLLocationDistance = 1000
	private var locationStoreManager: LocationStoreManagerProtocol = LocationStoreManager()

	lazy private var mapView: MKMapView = {
		let mapView = MKMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
		return mapView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = Constants.Texts.mapTitle
		view.backgroundColor = .systemBackground
		setupMapView()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		if let initialLocation = locationStoreManager.storedLocation?.locationObject {
			centerMapOnLocation(location: initialLocation)
			let address = Address(coordinate: initialLocation.coordinate)
			mapView.addAnnotation(address)
		} else {
			self.showAlertController(withText: "Ошибка!", message: "Надо сначала установить координаты вашего дома.")
		}
	}

	private func setupMapView() {
		view.addSubview(mapView)
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	private func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
												  latitudinalMeters: regionRadius,
												  longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: true)
	}
}
