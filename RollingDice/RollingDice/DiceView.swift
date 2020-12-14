//
//  DiceView.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import SwiftUI

struct DiceView: View {
    @ObservedObject var dice: Dice
    
    var body: some View {
        ZStack {
            Text("\(dice.value)")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.blue, lineWidth: 4)
                .frame(width:100, height:100)
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(dice: Dice(sides: 6))
    }
}
