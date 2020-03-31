//
//  Constants.swift
//  100metersTracker
//
//  Created by REUTSKIY YURIY on 30.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

enum Constants {
	enum Texts {
		static let description = "Приложение помогает определить, когда вы вышли за пределы радиуса 100 метров от своего дома.\n\nЧтобы настроить отслеживание, надо установить домашнюю точку. После этого приложение сможет видеть не ушли ли вы далеко."
		static let mainScreenNavigationBarTitle = "Гуляем вокруг 🏠"
		static let mainScreenTitle = "Главная"
		static let homeCoordinateButton = "Запомнить где дом 🎯"
		static let startTrackingButton = "Начать отслеживать 🚶‍♂️"
		static let stopTrackingButton = "Остановаить трекер 🚷"
		static let historyTitle = "Не придумал"
		static let mapTitle = "Карта"
		static let defaultDistanceTitle = "- метров"
	}

	enum Layout {
		static let defaultMargin: CGFloat = 20.0
		static let buttonHeight: CGFloat = 50.0
	}

	enum Keys {
		static let locationKey = "Location"
	}
}
