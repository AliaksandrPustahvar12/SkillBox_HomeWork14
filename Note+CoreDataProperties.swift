//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Aliaksandr Pustahvar on 11.12.22.
//
//

import Foundation
import CoreData

extension Note {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
}
