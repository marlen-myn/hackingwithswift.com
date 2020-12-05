//
//  PersonEditView.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import SwiftUI
import MapKit

struct PersonEditView: View {
    @Binding var contactImage: UIImage?
    @Binding var showPersonEditForm: Bool
    @Binding var contacts: [Person]
    @State private var contactName: String = ""
    let locationFetcher: LocationFetcher
    
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
            if let uuid = saveImage() {
                addContact(uuid)
                saveData()
            }
            showPersonEditForm = false
        })
    }
    
    func getLastKnowLoncation() -> CLLocationCoordinate2D {
        if let location = locationFetcher.lastKnownLocation {
            return location
        } else {
            return CLLocationCoordinate2D()
        }
    }
    
    func addContact(_ uuid: UUID) {
        let location = getLastKnowLoncation()
        let newContact = Person(id: UUID(), name: contactName, photoId: uuid, latitude: location.latitude, longitude: location.longitude)
        contacts.append(newContact)
    }
    
    func saveImage() -> UUID? {
        let id = UUID()
        do {
            try FileManager.saveImage(filename: id, image: contactImage!)
            print("image saved")
            return id
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(contacts)
            try FileManager.saveData(encodedData, filename: "SavedContacts")
            print("data saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}
