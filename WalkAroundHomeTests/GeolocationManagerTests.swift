//
//  _00metersTrackerTests.swift
//  100metersTrackerTests
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import XCTest
@testable import WalkAroundHomeTracker

/*
	Здорово было бы протестировать GeolocationManager, но для этого надо сделать дополнительную абстракцию над CLLocation
	и сделать мок для него, но времени как-то нет на это. Асинхронные запросы можно завернуть в expectation wait.
*/


class GeolocationManagerTests: XCTestCase {

	override func setUp() {

	}

	override func tearDown() {

	}

	func testExample() {

	}

	func testPerformanceExample() {
		measure {

		}
	}

}
