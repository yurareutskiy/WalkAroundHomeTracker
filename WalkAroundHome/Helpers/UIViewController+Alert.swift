//
//  UIViewController+Alert.swift
//  WalkAroundHome
//
//  Created by REUTSKIY YURIY on 01.04.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

extension UIViewController {
	func showAlertController(withText text: String?, message: String? = nil) {
		let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(action)

		self.present(alert, animated: true)
	}
}
