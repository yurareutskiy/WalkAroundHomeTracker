//
//  Constants.swift
//  100metersTracker
//
//  Created by REUTSKIY YURIY on 30.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

enum Constants {
	enum Main {
		static let description = "Приложение помогает определить, когда вы вышли за пределы радиуса 100 метров от своего дома.\n\nЧтобы настроить отслеживание, надо установить домашнюю точку. После этого приложение сможет видеть не ушли ли вы далеко."
		static let navigationBarTitle = "Гуляем вокруг 🏠"
		static let defaultDistanceTitle = "- метров"
		static let title = "Главная"
		static let homeCoordinateButton = "Запомнить где дом 🎯"
		static let startTrackingButton = "Начать отслеживать 🚶‍♂️"
		static let stopTrackingButton = "Остановаить трекер 🚷"
		static let alertExitTitle = "🚨🚨🚨"
		static let alertExitDescriptiton = "Вы вышли за пределы дома!"
		static let alertFailCoordinate = "Не смогли определить координаты, проверьте настройки."
		static let alertSuccessCoordinate = "Теперь можно начинать трекать перемещения вокруг дома."
		static let alertSuccessCoordinateTitle = "Определили координаты!"

		static func distanceTitle(forDistance distance: Double) -> String {
			"~\(Int(distance)) метров"
		}

		enum Layout {
			static let defaultMargin: CGFloat = 20.0
			static let buttonHeight: CGFloat = 50.0
		}
	}

	enum Alert {
		static let error = "Ошибка!"
		static let ok = "OK"
	}

	enum List {
		static let title = "Не придумал"
	}

	enum Map {
		static let title = "Карта"
		static let home = "Дом"
		static let regionRadius: Double = 1000
	}

	enum Error {
		static let coordinateFirst = "Надо сначала установить координаты вашего дома."
	}

	enum Keys {
		static let locationKey = "Location"
	}
}
