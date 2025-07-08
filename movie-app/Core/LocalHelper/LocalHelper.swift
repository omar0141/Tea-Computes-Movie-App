//
//  LocalHelper.swift
//  movie-app
//
//  Created by Omar on 08/07/2025.
//

import Foundation

class LocalHelper {
    
    static let shared = LocalHelper()
    
    private init() {}
    
    func saveObject<T: Codable>(key: String, value: T) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadObject<T: Codable>(key: String, type: T.Type) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode(type, from: data) else {
            return nil
        }
        return decoded
    }

    static func clear(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

