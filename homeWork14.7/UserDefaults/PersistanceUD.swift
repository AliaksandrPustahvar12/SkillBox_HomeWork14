//
//  PersistanceUD.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 1.12.22.
//

import Foundation

class PersistanceUD {
    static let shared = PersistanceUD()
    
    private let nameKey = "PersistanceUD.nameKey"
    var name: String? {
        get { UserDefaults.standard.string(forKey: nameKey)}
        set { UserDefaults.standard.set(newValue, forKey: nameKey) }
    }
    private let surnameKey = "PersistanceUD.surnameKey"
    var surname: String? {
        get { UserDefaults.standard.string(forKey: surnameKey)}
        set { UserDefaults.standard.set(newValue, forKey: surnameKey) }
    }
}
