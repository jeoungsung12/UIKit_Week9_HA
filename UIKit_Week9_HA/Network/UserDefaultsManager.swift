//
//  UserDefaultsManager.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/21/25.
//

import Foundation

@propertyWrapper
struct DefaultsStruct<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    enum Key: String {
        case food
        case water
        case level
    }
    @DefaultsStruct(key: Key.food.rawValue, defaultValue: 0)
    var foodValue
    @DefaultsStruct(key: Key.water.rawValue, defaultValue: 0)
    var waterValue
    @DefaultsStruct(key: Key.level.rawValue, defaultValue: 0)
    var levelValue
}
