//
//  EndGame.swift
//  Edutainment
//
//  Created by Marlen Mynzhassar on 21.11.2020.
//

import SwiftUI

struct EndGame: View {
    var score: Int
    @Binding var gameState: GameState
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                VStack(alignment: .center, spacing: 10) {
                    Text("Well done!")
                    Text("You have scored: \(score)")
                    Text("Try again, and you can do better!")
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation {
                            gameState = .settings
                        }
                    }, label: {
                        Text("Try again")
                            .font(.headline)
                            .frame(width: 100, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    .padding(10)
                }
            }
            .font(.title)
            .foregroundColor(.blue)
            .padding(.horizontal, 50)
            
            Spacer()
        }
    }
}
