//
//  ContentView.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activitites: Activities
    @State private var showAddForm = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activitites.items.indices, id: \.self) { idx in
                    NavigationLink(destination: ActivityEditView(activity: $activitites.items[idx])) {
                        VStack {
                            HStack {
                                Text(activitites.items[idx].title)
                                Spacer()
                                Text("completed: \(activitites.items[idx].completionCount) times")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteActivity)
            }
            .navigationTitle("HabitTracker")
            .navigationBarItems(leading: EditButton(), trailing: Button("Add new activity") {
                showAddForm = true
            })
            .sheet(isPresented: $showAddForm) {
                ActivityAddView(activitites: activitites)
            }
        }
    }
    
    private func deleteActivity(at offset: IndexSet) {
        activitites.deleteActivity(at: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(activitites: Activities())
    }
}
