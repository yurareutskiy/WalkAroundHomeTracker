//
//  LocationPoint.swift
//  WalkAroundHome
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationPoint: Codable {
	var latitude: Double
	var longitude: Double

	init(location: CLLocation) {
		latitude = location.coordinate.latitude
		longitude = location.coordinate.longitude
	}

	var locationObject: CLLocation {
		CLLocation(latitude: latitude, longitude: longitude)
	}

	var displayName: String {
		locationObject.description
	}
}
