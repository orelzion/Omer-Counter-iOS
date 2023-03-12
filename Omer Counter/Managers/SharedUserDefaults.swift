//
//  SharedUserDefaults.swift
//  Omer Counter
//
//  Created by Orel Zion on 20/04/2021.
//
import Foundation

class SharedUserDefaults {
    static let suiteName = "group.com.github.orelzion.Omer-Counter"
    
    struct keys {
        static let nusach = "nusach"
        static let location = "last_location"
    }
    
    static func create() -> UserDefaults {
        return UserDefaults.init(suiteName: suiteName)!
    }
}
