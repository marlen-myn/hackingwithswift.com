//
//  ContentView.swift
//  BucketList
//
//  Created by Marlen Mynzhassar on 02.12.2020.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct MapViewWrapper: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    
    var body: some View {
        MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
            .edgesIgnoringSafeArea(.all)
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width:32, height: 32)
    }
}

struct ButtonView: View {
    var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    let newLocation = CodableMKPointAnnotation()
                    newLocation.coordinate = centerCoordinate
                    newLocation.title = "Example location"
                    locations.append(newLocation)
                    selectedPlace = newLocation
                    showingEditScreen = true
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation? // pointer to a class object
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    @State private var isBiometricError = false
    @State private var biometricErrorDescription = ""
    
    var body: some View {
        
        let selectedPlaceBinding = Binding<MKPointAnnotation?> (
            get: {
                selectedPlace
            },
            set: {
                selectedPlace = $0
            }
        )
        
        return ZStack {
            if isUnlocked {
                MapViewWrapper(centerCoordinate: $centerCoordinate, locations: $locations, selectedPlace: selectedPlaceBinding, showingPlaceDetails: $showingPlaceDetails)
                ButtonView(centerCoordinate: centerCoordinate, locations: $locations, selectedPlace: selectedPlaceBinding, showingEditScreen: $showingEditScreen)
            } else {
                Button("Unlock places") {
                    authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            if isBiometricError {
                return Alert(title: Text("Biometric Error"), message: Text(biometricErrorDescription), dismissButton: .default(Text("Ok")) {
                    isBiometricError = false
                })
            } else {
                return Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    showingEditScreen = true
                })
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if selectedPlace != nil {
                EditView(placemark: selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
    
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        showingPlaceDetails = true
                        isBiometricError = true
                        biometricErrorDescription = authenticationError?.localizedDescription ?? "Unknown Error"
                    }
                }
            }
        } else {
            print("No biometry")
        }
    }
}
