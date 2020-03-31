//
//  ActionButton.swift
//  100metersTracker
//
//  Created by REUTSKIY YURIY on 30.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

	convenience init(defaultText text: String) {
		self.init()
		setTitle(text, for: .normal)
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 17.0
		backgroundColor = .systemGray
		titleLabel?.font = UIFont.defaultButtonFont
	}

	func setEnabled(_ enable: Bool) {
		isEnabled = enable
		alpha = enable ? 1.0 : 0.6
	}
}
