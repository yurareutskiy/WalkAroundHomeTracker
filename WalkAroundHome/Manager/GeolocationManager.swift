//
//  GeolocationManager.swift
//  100metersTracker
//
//  Created by REUTSKIY YURIY on 30.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation
import CoreLocation

typealias BoolCompletion = (Bool) -> Void
typealias DistanceCompletion = (Double) -> Void

private enum GeolocationProccesType {
	case searchHomePoint
	case monitorUserPosition
	case none
}

protocol GeolocationManagerProtocol {
	var homeLocationDeterminated: Bool { get }
	func determineHomeCoordinate(_ completion: @escaping BoolCompletion)
	func startMonitoring(_ completion: @escaping BoolCompletion)
	func stopMonitoring()
	func setDistanceUpdate(_ completion: @escaping DistanceCompletion)
}

class GeolocationManager: NSObject, GeolocationManagerProtocol {
	private var locationStoreManager: LocationStoreManagerProtocol = LocationStoreManager()
	private var geolocationProccesType: GeolocationProccesType = .none
	private let locationManager = CLLocationManager()
	private var homeLocation: CLLocation? {
		didSet {
			locationStoreManager.saveLocation(homeLocation)
		}
	}
	private var homeLocationUpdateCompletion: BoolCompletion?
	private var exitRegionCompletion: BoolCompletion?
	private var distanceUpdateCompletion: DistanceCompletion?

	override init() {
		super.init()
		self.homeLocation = locationStoreManager.storedLocation?.locationObject
	}

	var homeLocationDeterminated: Bool {
		return homeLocation != nil
	}

	func setDistanceUpdate(_ completion: @escaping DistanceCompletion) {
		distanceUpdateCompletion = completion
	}

	func determineHomeCoordinate(_ completion: @escaping BoolCompletion) {
		geolocationProccesType = .searchHomePoint
		homeLocationUpdateCompletion = completion
		locationManager.delegate = self;
		locationManager.requestAlwaysAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestLocation()
	}

	func startMonitoring(_ completion: @escaping BoolCompletion) {
		geolocationProccesType = .monitorUserPosition
		exitRegionCompletion = completion
		locationManager.delegate = self
		locationManager.allowsBackgroundLocationUpdates = true
		locationManager.startUpdatingLocation()
		locationManager.pausesLocationUpdatesAutomatically = false
		locationManager.showsBackgroundLocationIndicator = true
		locationManager.activityType = .fitness
		guard let locaction2D: CLLocationCoordinate2D = homeLocation?.coordinate,
			let region = region(forCenter: locaction2D)
		else {
			return
		}
		locationManager.startMonitoring(for: region)
	}

	func stopMonitoring() {
		geolocationProccesType = .none
		locationManager.stopUpdatingLocation()
	}

	private func region(forCenter center: CLLocationCoordinate2D) -> CLRegion? {
		guard CLLocationManager.authorizationStatus() == .authorizedAlways,
			CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
		else {
			return nil
		}

		let maxDistance = 100.0
		let region = CLCircularRegion(center: center,
									  radius: maxDistance, identifier: "\(Date().timeIntervalSince1970)")
		region.notifyOnEntry = false
		region.notifyOnExit = true

		return region
	}
}

extension GeolocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }

		switch geolocationProccesType {
		case .monitorUserPosition:
			updateUserDistance(withLocation: location)
		case .searchHomePoint:
			updateHomeLocation(location)
		default:
			return
		}
	}

	private func updateUserDistance(withLocation location: CLLocation) {
		let distance = homeLocation?.distance(from: location)
		distanceUpdateCompletion?(distance ?? 0.0)
	}

	private func updateHomeLocation(_ location: CLLocation) {
		// TODO: Настроить точность, сейчаса большой разброс и долго ждать
		guard location.verticalAccuracy > 0.0 && location.horizontalAccuracy > 0.0 else {
			return
		}

		homeLocation = location
		homeLocationUpdateCompletion?(true)
		geolocationProccesType = .none
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		switch geolocationProccesType {
		case .monitorUserPosition:
			exitRegionCompletion?(false)
		case .searchHomePoint:
			homeLocationUpdateCompletion?(false)
		default:
			return
		}
		geolocationProccesType = .none
	}

	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		geolocationProccesType = .none
		exitRegionCompletion?(true)
	}
}
