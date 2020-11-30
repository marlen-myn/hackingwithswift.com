//
//  CDFriend+CoreDataProperties.swift
//  MyCircle
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//
//

import Foundation
import CoreData


extension CDFriend {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }
    
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var user: CDUser
    
    var userDetails: CDUser {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        return try! context.fetch(fetchRequest).first!
    }
}

extension CDFriend : Identifiable {
    
}
