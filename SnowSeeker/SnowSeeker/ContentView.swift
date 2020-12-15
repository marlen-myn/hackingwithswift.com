//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Marlen Mynzhassar on 15.12.2020.
//

import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

enum ResortFilter: String {
    case name, country
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @State private var resorts = [Resort]()
    @State private var setFilter = ResortFilter.name
    @State private var isSortedSheet = false
    @State private var isFilterSheet = false
    
    @State private var selectedCountry = "All"
    @State private var selectedPrice = "All"
    @State private var selectedSize = "All"
    
    let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Sorted by: \(setFilter.rawValue)")
                        .font(.footnote)
                    Spacer()
                }
                .padding([.leading, .top])
                
                List(resorts.sorted(by: sorter)) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
                .sheet(isPresented: $isFilterSheet, onDismiss: applyFilter) {
                    FilterView(selectedCountry: $selectedCountry, selectedPrice: $selectedPrice, selectedSize: $selectedSize)
                }
                .actionSheet(isPresented: $isSortedSheet) {
                    ActionSheet(title: Text("Sort Resorts"), message: Text("Select parameter to sort by"), buttons: [
                        .default(Text("Name")) { self.setFilter = ResortFilter.name },
                        .default(Text("Country")) { self.setFilter = ResortFilter.country },
                        .cancel()
                    ])
                }
                .navigationBarTitle("Resorts", displayMode: .inline)
                .navigationBarItems(leading: Button("Sort") { isSortedSheet = true } , trailing:Button("Filter") { isFilterSheet = true } )
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
        .onAppear() {
            resorts = allResorts
        }
    }
    
    func applyFilter() {
        resorts = allResorts.filter( { selectedCountry != "All" ? $0.country == selectedCountry : true } )
        resorts = resorts.filter( { selectedSize != "All" ? $0.friendlySize == selectedSize : true } )
    }
    
    func sorter(val1: Resort, val2: Resort) -> Bool {
        switch setFilter {
        case .name:  return val1.name < val2.name
        case .country: return val1.country < val2.country
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
