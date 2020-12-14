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
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.blue)
                .frame(width:100, height:100)
            
            Text("\(dice.value)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(dice: Dice(sides: 6))
    }
}
