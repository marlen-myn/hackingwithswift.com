//
//  PersonView.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import SwiftUI
import UIKit

struct PersonView: View {
    var contact: Person
    @State private var image: Image?
    
    var body: some View {
        VStack {
            Text(contact.name)
                .font(.title)
                .padding()
            
            if image != nil {
                image!
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No image available")
            }
            
            Spacer()
        }
        .onAppear() {
            loadImage()
        }
    }
    
    func loadImage() {
        let url = FileManager.getDataURL(filename: contact.photoId.uuidString)
        do {
            let data = try Data(contentsOf: url)
            let uiImage = UIImage(data: data)
            image = Image(uiImage: uiImage!)
        } catch {
            print(error.localizedDescription)
        }
    }
}	
