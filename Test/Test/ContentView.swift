//
//  ContentView.swift
//  Test
//
//  Created by Marlen Mynzhassar on 04.12.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        HStack {
            Button(action: {
                isUnlocked = true
            }) {
                Image(systemName: "plus")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
            }
            .background(Color.black) // clickable whole area
            .padding() // not clickable
            .background(Color.blue) // color the padding so we can see it
            .clipShape(Rectangle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
