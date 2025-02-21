//
//  UserDefaultsManager.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/21/25.
//

import Foundation

@propertyWrapper
struct DefaultsStruct<T: Codable> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key),
                  let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                return defaultValue
            }
            return decoded
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    enum Key: String {
        case userInfo
    }
    
    @DefaultsStruct(
        key: Key.userInfo.rawValue,
        defaultValue: UserInfo(
            iconData: nil,
            nickname: "대장",
            foodValue: 0,
            waterValue: 0,
            levelValue: 1
        )
    )
    var userInfo
    
    func removeValue(_ key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
