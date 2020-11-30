//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Marlen Mynzhassar on 29.11.2020.
//

import SwiftUI
import CoreData

enum PredicateType {
    case beginsWith
    case contains
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {    
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortValues: [
                NSSortDescriptor(keyPath: \Singer.firstName, ascending: true),
                NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)
            ], predicate: .contains) { (singer: Singer) in
                Text("\(singer.wrappedFirstName)")
                Text("\(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
