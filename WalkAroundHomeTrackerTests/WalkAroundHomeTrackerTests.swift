//
//  WalkAroundHomeTrackerTests.swift
//  WalkAroundHomeTrackerTests
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WalkAroundHomeTracker

class WalkAroundHomeTrackerTests: XCTestCase {

	override func setUp() {
		let defaults = UserDefaults.standard
		let dictionary = defaults.dictionaryRepresentation()
		dictionary.keys.forEach { key in
			defaults.removeObject(forKey: key)
		}
	}

	func testSavePointLocationStoreManager() {
		// Given
		let locationStoreManager = LocationStoreManager()
		let location = CLLocation(latitude: 55.7731218181041, longitude: 37.68377595168065)

		// When
		locationStoreManager.saveLocation(location)

		// Then
		let data = UserDefaults.standard.data(forKey: Constants.Keys.locationKey)
		XCTAssert(data != nil, "Data from user default is nil")

		let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
		XCTAssert(json != nil, "Json after parsing is nil")

		XCTAssert(json!["latitude"] != nil, "There's no latitude")
		XCTAssert(json!["longitude"] != nil, "There's no longitude")

		XCTAssert(json!["latitude"] as! Double == 55.7731218181041, "Latitude is wrong")
		XCTAssert(json!["longitude"] as! Double == 37.68377595168065, "Longitude is wrong")
	}

	func testRetrievePointLocationStoreManager() {
		// Given
		let dict = ["latitude": 55.7731218181041, "longitude": 37.68377595168065]
		let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
		UserDefaults.standard.set(data, forKey: Constants.Keys.locationKey)
		let locationStoreManager = LocationStoreManager()

		// When
		let point = locationStoreManager.storedLocation

		// Then
		XCTAssert(point != nil, "Retrieved point is nil")

		XCTAssert(point?.latitude == 55.7731218181041, "Latitude is wrong")
		XCTAssert(point?.longitude == 37.68377595168065, "Longitude is wrong")
	}
}
