//
//  LocationStoreManager.swift
//  WalkAroundHome
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationStoreManagerProtocol {
	func saveLocation(_ location: CLLocation?)
	var storedLocation: LocationPoint? { get }
}

class LocationStoreManager: LocationStoreManagerProtocol {

	func saveLocation(_ location: CLLocation?) {
		guard let location = location else { return }
		let point = LocationPoint(location: location)
		point.saveData(forKey: Constants.Keys.locationKey)
	}

	var storedLocation: LocationPoint? {
		LocationPoint.retriveObject(forKey: Constants.Keys.locationKey)
	}

}

