//
//  WrongAnswerCard.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 24/02/22.
//

import SwiftUI

struct WrongAnswerCard: View {
    @EnvironmentObject private var vm: ContentModel
    let multiplication: String
    let answer: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .shadow(radius: 3)

            VStack(spacing: 15) {
                SadEmojiView(size: 85)
                    .padding(.top, 5)
                
                Text("\(multiplication) = \(answer)")
                    .font(.system(size: 42, weight: .semibold, design: .default))
                Spacer(minLength: 0)
                Button {
                    vm.showNextScreen()
                } label: {
                    Text("Continue")
                        .asDefaultButton(foregroundColor: .white, backgroundColor: .theme.darkBlue)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .frame(height: 320)
    }
}

struct WrongAnswerCard_Previews: PreviewProvider {
    static var previews: some View {
        WrongAnswerCard(multiplication: "6 x 3", answer: 18)
            .environmentObject(ContentModel())
    }
}
