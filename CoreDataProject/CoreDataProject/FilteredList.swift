//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Marlen Mynzhassar on 29.11.2020.
//

import SwiftUI
import CoreData

struct FilteredList<T:NSManagedObject, Content:View> : View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, sortValues: [NSSortDescriptor], predicate: PredicateType, @ViewBuilder content: @escaping (T) -> Content) {
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortValues,
                                       predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            content(singer)
        }
    }
    
}
