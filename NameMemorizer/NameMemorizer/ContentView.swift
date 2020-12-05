//
//  ContentView.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var contacts = [Person]()
    @State private var showPersonEditForm = false
    @State private var showImagePickerView = false
    @State private var contactImage: UIImage?
    
    var body: some View {
         NavigationView {
                if showPersonEditForm, contactImage != nil {
                    PersonEditView(contactImage: $contactImage, showPersonEditForm: $showPersonEditForm, contacts: $contacts)
                } else {
                    List {
                        ForEach(contacts.sorted()) { contact in
                            NavigationLink(destination: PersonView(contact : contact)) {
                                Text(contact.name)
                            }
                        }
                    }
                    .sheet(isPresented: $showImagePickerView) {
                        ImagePickerView(image: $contactImage, showPersonEditForm: $showPersonEditForm)
                    }
                    .navigationBarTitle(Text("NameMemorizer"), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        showImagePickerView = true
                    }) {
                        Image(systemName: "plus")
                    })
                }
        }
        .onAppear() {
            loadData()
        }
    }
    
    func loadData() {
        let filename = FileManager.getDataURL(filename: "SavedContacts")
        do {
            let data = try Data(contentsOf: filename)
            contacts = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
