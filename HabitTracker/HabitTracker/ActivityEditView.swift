//
//  ActivityEditView.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import SwiftUI

struct ActivityEditView: View {
    var activity: Activity
    @ObservedObject var activitites: Activities
    
    var activityIndex: Int {
        activitites.activitites.firstIndex(where: { $0.id == activity.id })!
    }
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $activitites.activitites[activityIndex].title)
            }
            Section(header: Text("Description")) {
                TextField("Description", text: $activitites.activitites[activityIndex].description)
            }
            Section(header: Text("Times completed")) {
                Stepper(value: $activitites.activitites[activityIndex].completionCount,
                        in: 0...100){
                    Text("\(activitites.activitites[activityIndex].completionCount)")
                }
            }
        }
        .navigationTitle(Text(activity.title))
    }
}

struct ActivityEditView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Activities()
        ActivityEditView(activity:model.activitites[0], activitites:model)
    }
}
