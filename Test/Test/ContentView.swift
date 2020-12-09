//
//  ContentView.swift
//  Test
//
//  Created by Marlen Mynzhassar on 08.12.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(){
                let s = "(("
                isValid(s)
            }
    }
    
    func isValid(_ s: String) -> Bool {
        guard s.count % 2 == 0 else { return false }
        let left = ["(", "[", "{"]
        let right = [")", "]", "}"]
        var tempArray = Array(s)
        var lastIndex = 0
        var counter = 0
        
        while counter < tempArray.count {
            let symbol = tempArray[counter]
            if left.contains(String(symbol)) {
                lastIndex = counter
            } else {
                if let rightIndex = right.firstIndex(of: String(symbol)) {
                    if left[rightIndex] == String(tempArray[lastIndex]) {
                        tempArray.remove(at: counter)
                        tempArray.remove(at: lastIndex)
                        if lastIndex > 0 {
                            lastIndex -= 1
                        } else {
                            lastIndex = 0
                        }
                        counter = lastIndex
                        continue
                    } else {
                        return false
                    }
                }
            }
            counter += 1
        }
        
        return (tempArray.count > 0) ? false : true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
