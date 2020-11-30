//
//  CDTag+CoreDataProperties.swift
//  MyCircle
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//
//

import Foundation
import CoreData


extension CDTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTag> {
        return NSFetchRequest<CDTag>(entityName: "CDTag")
    }

    @NSManaged public var name: String
    @NSManaged public var user: CDUser

}

extension CDTag : Identifiable {

}
