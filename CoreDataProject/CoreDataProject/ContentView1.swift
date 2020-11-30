//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Marlen Mynzhassar on 29.11.2020.
//

import SwiftUI
import CoreData

struct ContentView1: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    func deleteCandy(country: Country, at offsets: IndexSet) {
        for index in offsets {
            let candy = country.candyArray[index]
            moc.delete(candy)
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    ForEach(countries, id: \.self) { country in
                        Section(header: Text(country.wrappedFullName)) {
                            ForEach(country.candyArray, id: \.id) { candy in
                                Text(candy.wrappedName)
                            }
                            .onDelete(perform: { indexSet in
                                deleteCandy(country: country, at: indexSet)
                            })
                        }
                    }
                }
                
                Button("Add") {
                    let candy1 = Candy(context: self.moc)
                    candy1.name = "Mars"
                    candy1.origin = Country(context: self.moc)
                    candy1.origin?.shortName = "UK"
                    candy1.origin?.fullName = "United Kingdom"
                    
                    let candy2 = Candy(context: self.moc)
                    candy2.name = "KitKat"
                    candy2.origin = Country(context: self.moc)
                    candy2.origin?.shortName = "UK"
                    candy2.origin?.fullName = "United Kingdom"
                    
                    let candy3 = Candy(context: self.moc)
                    candy3.name = "Twix"
                    candy3.origin = Country(context: self.moc)
                    candy3.origin?.shortName = "UK"
                    candy3.origin?.fullName = "United Kingdom"
                    
                    let candy4 = Candy(context: self.moc)
                    candy4.name = "Toblerone"
                    candy4.origin = Country(context: self.moc)
                    candy4.origin?.shortName = "CH"
                    candy4.origin?.fullName = "Switzerland"
                    
                    try? self.moc.save()
                }
            }
            .navigationTitle("Candy Shop")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
