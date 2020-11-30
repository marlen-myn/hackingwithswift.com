//
//  ContentView.swift
//  MyCircle
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: []) var items: FetchedResults<CDUser>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { user in
                    NavigationLink(destination: UserView(user: user)) {
                        VStack(alignment: .leading) {
                            Group {
                                Text(user.name)
                                    .font(.headline)
                                Text("\(user.company) \(user.email)")
                                Text("friends: \(user.friends.count)")
                                    .font(.footnote)
                            }
                            .foregroundColor(user.isActive ? .green : .gray)
                        }
                    }
                }
            }
            .navigationTitle("Friends Circle")
        }
        .onAppear() {
            UserClass.synchronizeData(in: moc)
        }
    }
}

