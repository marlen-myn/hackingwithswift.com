//
//  CardView.swift
//  Flashzilla
//
//  Created by Marlen Mynzhassar on 10.12.2020.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var feedback = UINotificationFeedbackGenerator()
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    let card: Card
    var delaying: (() -> Void)? = nil
    var removal: (() -> Void)? = nil
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    func getOfsetColor() -> Color {
        if offset.width > 0 {
            return Color.green
        } else if offset.width < 0 {
            return Color.red
        } else {
            return Color.white
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background (
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(getOfsetColor())
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width:450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 3, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    self.feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if self.offset.width > 0 {
                            self.removal?()
                        } else {
                            self.feedback.notificationOccurred(.error)
                            self.delaying?()
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}
