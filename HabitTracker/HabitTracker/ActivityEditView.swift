//
//  ActivityEditView.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import SwiftUI

struct ActivityEditView: View {
    @Binding var activity: Activity
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $activity.title)
            }
            Section(header: Text("Description")) {
                TextField("Description", text: $activity.description)
            }
            Section(header: Text("Times completed")) {
                Stepper(value: $activity.completionCount, in: 0...100) {
                    Text("\(activity.completionCount)")
                }
            }
        }
        .navigationTitle(Text(activity.title))
    }
}

//struct ActivityEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        @ObservedObject let model = Activities()
//        ActivityEditView(activity: $model.items[0])
//    }
//}
