//
//  Codable+UserDefaults.swift
//  WalkAroundHome
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation

extension Encodable {
	func saveData(forKey key: String) {
		if let data = try? self.jsonData() {
			UserDefaults.standard.set(data, forKey: key)
		}
	}

	private func jsonData() throws -> Data? {
		let encoder = JSONEncoder()
		let data = try encoder.encode(self)
		return data
	}
}

extension Decodable {

	static func retriveObject<T: Decodable>(forKey key: String) -> T? {
		guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
		let decoder = JSONDecoder()
		let object = try? decoder.decode(T.self, from: data)
		return object
	}

}
