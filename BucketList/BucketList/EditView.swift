//
//  EditView.swift
//  BucketList
//
//  Created by Marlen Mynzhassar on 03.12.2020.
//

import SwiftUI
import MapKit

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrapppedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                Section(header: Text("Nearby")) {
                    if loadingState == .loaded {
                        List(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                .italic()
                        }
                    } else if loadingState == .loading {
                        Text("Loading")
                    } else {
                        Text("PLease try again later")
                    }
                }
            }
            .navigationBarTitle("Edit Place")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
        }
    }
    
    func fetchNearbyPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let items = try? decoder.decode(Result.self, from: data) {
                    pages = Array(items.query.pages.values).sorted()
                    loadingState = .loaded
                    return
                }
            }
            loadingState = .failed
        }.resume()
    }
}
