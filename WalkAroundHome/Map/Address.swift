//
//  Address.swift
//  WalkAroundHome
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


class Address: NSObject, MKAnnotation {
	var title: String? = "Дом"

	var coordinate: CLLocationCoordinate2D

	init(coordinate: CLLocationCoordinate2D) {
		self.coordinate = coordinate
		super.init()
	}

	var subtitle: String? {
		return "\(coordinate)"
	}
}
