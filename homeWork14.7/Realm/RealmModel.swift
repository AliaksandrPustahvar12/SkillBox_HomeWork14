//
//  RealmModel.swift
//  homeWork14.7
//
//  Created by Aliaksandr Pustahvar on 1.12.22.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class PersistanceR {
    static let shared = PersistanceR()
    private let realm = try! Realm()
    
    func addItem(name: String, date: Date) {
        realm.beginWrite()
        let newItem = ToDoItem()
        newItem.item = name
        newItem.date = date
        realm.add(newItem)
        try! realm.commitWrite()
    }
    func deleteItem(item: ToDoItem) {
        realm.beginWrite()
        realm.delete(item)
        try! realm.commitWrite()
    }
}
