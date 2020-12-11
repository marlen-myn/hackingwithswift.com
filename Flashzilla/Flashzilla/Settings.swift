//
//  Settings.swift
//  Flashzilla
//
//  Created by Marlen Mynzhassar on 11.12.2020.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var tryAgainOption: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $tryAgainOption) {
                    Text("To try again")
                }.padding()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}
