//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Marlen Mynzhassar on 15.12.2020.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCountry: String
    @Binding var selectedPrice: String
    @Binding var selectedSize: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Country")) {
                    Picker(selection: $selectedCountry, label: Text("Select a country")) {
                        Text("All").tag("All")
                        ForEach(Array(Set(Resort.allCountries)).sorted(), id:\.self) {
                            Text($0).tag($0)
                        }
                    }
                }
                Section(header: Text("Size")) {
                    Picker(selection: $selectedSize, label: Text("Select a size")) {
                        Text("All").tag("All")
                        ForEach(Array(Set(Resort.allSizes)).sorted(), id:\.self) {
                            Text(sizeName($0)).tag(sizeName($0))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Filter")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func sizeName(_ size: Int) -> String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
}
