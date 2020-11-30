//
//  CDUser+CoreDataProperties.swift
//  MyCircle
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//
//

import Foundation
import CoreData


extension CDUser {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }
    
    @NSManaged public var age: Int16
    @NSManaged public var about: String
    @NSManaged public var address: String
    @NSManaged public var company: String
    @NSManaged public var email: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: Date
    @NSManaged public var friends: NSSet
    @NSManaged public var tags: NSSet
    
    var friendsArray: [CDFriend] {
        let set = friends as? Set<CDFriend> ?? []
        
        return set.sorted {
            $0.name < $1.name
        }
    }
    
    var friendlyDateRegistered: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: registered)
    }
    
    var friendlyUserTags: String {
        var tagsToReturn = ""
        for tag in tags {
            let tagToSave = tag as? CDTag
            tagsToReturn += "\(tagToSave!.name) "
        }
        
        return tagsToReturn
    }
}

// MARK: Generated accessors for friends
extension CDUser {
    
    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CDFriend)
    
    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CDFriend)
    
    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)
    
    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)
    
}

// MARK: Generated accessors for tags
extension CDUser {
    
    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: CDTag)
    
    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: CDTag)
    
    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)
    
    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)
    
}

extension CDUser : Identifiable {
    
}
