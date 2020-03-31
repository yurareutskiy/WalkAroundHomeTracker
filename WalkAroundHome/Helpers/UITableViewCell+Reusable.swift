//
//  Reusable.swift
//  100metersTracker
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

protocol Reusable: class {
	static var reuseIdentifier: String { get }
}

extension Reusable {
	static var reuseIdentifier: String {
		return "\(self)"
	}
}

extension UITableViewCell: Reusable {}

extension UITableView {

	func registerReusable<T: Reusable>(cellClass: T.Type) {
		register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
	}

	func dequeueReusableCell<T: UITableViewCell>(withClass reusableClass: T.Type) -> T? {
		return dequeueReusableCell(withIdentifier: reusableClass.reuseIdentifier) as? T
	}
}
