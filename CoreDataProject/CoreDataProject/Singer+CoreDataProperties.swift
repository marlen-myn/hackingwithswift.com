//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Marlen Mynzhassar on 29.11.2020.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
