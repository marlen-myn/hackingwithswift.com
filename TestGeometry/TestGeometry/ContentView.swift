//
//  ContentView.swift
//  TestGeometry
//
//  Created by Marlen Mynzhassar on 13.12.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                GeometryReader { geoInner in
                    HStack {
                        Spacer()
                        Image("tako")
                            .resizable()
                            .scaledToFit()
                            .frame(width: (geoInner.frame(in: .global).midY > 100) ? geoInner.frame(in: .global).midY : 100,
                                   height: geo.size.height * 0.5)
                        Spacer()
                    }
                    .onTapGesture {
                        print("Medium Y: \(geoInner.frame(in: .global).midY)")
                    }
                }
                .frame(height: geo.size.height * 0.5)
                //.background(Color.green)
                
                Text("Hello, world!")
                    .frame(height: 300)
                    .background(Color.yellow)
                
                Text("Hello, world!")
                    .frame(height: 300)
                    .background(Color.blue)
            }
            .frame(width: geo.size.width)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
