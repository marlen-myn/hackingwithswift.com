//
//  CardView.swift
//  Test2
//
//  Created by Marlen Mynzhassar on 11.12.2020.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @State private var offset = CGSize.zero
    var addClosure: () -> Void
    var removeClosure: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            VStack {
                Text(card.title)
                Text(card.description)
            }
        }
        .frame(width:200, height: 200)
        .offset(x: offset.width * 3, y: 0)
        .gesture (
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { gesture in
                    if abs(offset.width) > 40 {
                        if self.offset.width > 0 {
                            removeClosure()
                        } else {
                            addClosure()
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .animation(.spring())
    }
}
