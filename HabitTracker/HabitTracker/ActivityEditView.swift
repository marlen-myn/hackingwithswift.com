//
//  ActivityEditView.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import SwiftUI

struct ActivityEditView: View {
    let activityIndex: Int
    @ObservedObject var activitites: Activities
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $activitites.items[activityIndex].title)
            }
            Section(header: Text("Description")) {
                TextField("Description", text: $activitites.items[activityIndex].description)
            }
            Section(header: Text("Times completed")) {
                Stepper(value: $activitites.items[activityIndex].completionCount,
                        in: 0...100){
                    Text("\(activitites.items[activityIndex].completionCount)")
                }
            }
        }
        .navigationTitle(Text(activitites.items[activityIndex].title))
    }
}

struct ActivityEditView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityEditView(activityIndex: 0, activitites: Activities())
    }
}
