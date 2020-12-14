//
//  Roll+CoreDataProperties.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var rollquantity: Int16
    @NSManaged public var sides: Int16
    @NSManaged public var total: Int16
    
    var friendlyDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

extension Roll : Identifiable {

}
