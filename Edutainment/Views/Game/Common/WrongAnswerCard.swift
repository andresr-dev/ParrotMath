//
//  WrongAnswerCard.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 24/02/22.
//

import SwiftUI

struct WrongAnswerCard: View {
    @EnvironmentObject var vm: ContentModel
    let emojis = ["😔", "😫", "😟", "😩"]
    let multiplication: String
    let answer: Int
    @State private var animate = false
    @State private var emojiSelected = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .shadow(radius: 3)

            VStack(spacing: 15) {
                Text(emojiSelected)
                    .font(.system(size: 85))
                    .scaleEffect(animate ? 1.15 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
                    .shadow(radius: 3)
                    .padding(.top, 15)
                
                Text("\(multiplication) = \(answer)")
                    .font(.system(size: 45, weight: .semibold, design: .default))
                Spacer()
                Button {
                    vm.newQuestion()
                } label: {
                    Text("Continue")
                        .asDefaultButton(foregroundColor: .white, backgroundColor: .theme.darkBlue)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .frame(height: 330)
        .onAppear {
            emojiSelected = emojis.randomElement() ?? "😭"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animate = true
            }
        }
    }
}

struct WrongAnswerCard_Previews: PreviewProvider {
    static var previews: some View {
        WrongAnswerCard(multiplication: "6 x 3", answer: 18)
            .environmentObject(ContentModel())
    }
}
