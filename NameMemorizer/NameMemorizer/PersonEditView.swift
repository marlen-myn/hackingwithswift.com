//
//  PersonEditView.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import SwiftUI

struct PersonEditView: View {
    @Binding var contactImage: UIImage?
    @Binding var showPersonEditForm: Bool
    @Binding var contacts: [Person]
    @State private var contactName: String = ""
    
    var body: some View {
        VStack {
            Form {
                Image(uiImage: contactImage!)
                        .resizable()
                        .scaledToFit()
                Section(header: Text("Person's name")) {
                    TextField("Type the name ", text: $contactName)
                }
            }

            Spacer()
        }
        .navigationBarTitle(Text("Add Contact"), displayMode: .inline)
        .navigationBarItems(leading: Button("Cancel") {
            showPersonEditForm = false
        }, trailing: Button("Save") {
            saveData()
            showPersonEditForm = false
        })
    }
    
    func saveData() {
        let newContact = Person(id: UUID(), name: contactName, photoId: UUID())
        contacts.append(newContact)
        // encode data into JSON from contacts list
        // save data into user's document file system
    }
}
