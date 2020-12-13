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
            VStack {
                GeometryReader { geoInner in
                    Text("Press")
                        .onTapGesture {
                            print("geo width: \(geo.size.width)")
                            print("geo height: \(geo.size.height)")
                            print("minY : \(geo.frame(in: .global).minY)")
                            print("midY : \(geo.frame(in: .global).midY)")
                            print("maxY : \(geo.frame(in: .global).maxY)")
                            print("minX : \(geo.frame(in: .global).minX)")
                            print("midX : \(geo.frame(in: .global).midX)")
                            print("maxX : \(geo.frame(in: .global).maxX)")
                            print("- - - local -- -- - - -")
                            print("minY : \(geo.frame(in: .local).minY)")
                            print("midY : \(geo.frame(in: .local).midY)")
                            print("maxY : \(geo.frame(in: .local).maxY)")
                            print("minX : \(geo.frame(in: .local).minX)")
                            print("midX : \(geo.frame(in: .local).midX)")
                            print("maxX : \(geo.frame(in: .local).maxX)")
                            print("- - -- - - -- - - -")
                            print("geoInner width: \(geoInner.size.width)")
                            print("geoInner height: \(geoInner.size.height)")
                            print("minY : \(geoInner.frame(in: .global).minY)")
                            print("midY : \(geoInner.frame(in: .global).midY)")
                            print("maxY : \(geoInner.frame(in: .global).maxY)")
                            print("minX : \(geoInner.frame(in: .global).minX)")
                            print("midX : \(geoInner.frame(in: .global).midX)")
                            print("maxX : \(geoInner.frame(in: .global).maxX)")
                            print("- - - local -- -- - - -")
                            print("minY : \(geoInner.frame(in: .local).minY)")
                            print("midY : \(geoInner.frame(in: .local).midY)")
                            print("maxY : \(geoInner.frame(in: .local).maxY)")
                            print("minX : \(geoInner.frame(in: .local).minX)")
                            print("midX : \(geoInner.frame(in: .local).midX)")
                            print("maxX : \(geoInner.frame(in: .local).maxX)")
                        }
                }
            }
            .frame(width:geo.size.width/2, height:geo.size.height/2)
            .background(Color.blue)
        }
        .background(Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
