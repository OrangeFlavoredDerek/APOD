//
//  UserDefaults+Helper.swift
//  Apod-SwiftUI
//
//Created by Derek Chan on 2020/7/30.
//

import Foundation


extension UserDefaults {
    enum UserKey: String {
        case ApiKey
        case AutoHdImage
    }
    
    static func saveCustomValue(for key: UserKey, value: Any) {
        self.standard.set(value, forKey: key.rawValue)
    }
    
    static func getCustomValue(for key: UserKey) -> Any? {
        self.standard.object(forKey: key.rawValue)
    }
}
