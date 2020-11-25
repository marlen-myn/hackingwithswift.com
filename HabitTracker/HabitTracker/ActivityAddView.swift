//
//  ActivityAddView.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import SwiftUI

struct ActivityAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activitites: Activities
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Activity title")){
                    TextField("Type your activity", text: $title)
                }
                Section(header: Text("Activity description")){
                    TextField("Type your activity", text: $description)
                }
            }
            .navigationTitle("Add new activity")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let newActivity = Activity(title: title, description: description)
                activitites.addActivity(newActivity)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ActivityAddView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityAddView(activitites: Activities())
    }
}
