//
//  ResultView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 24/02/22.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject private var vm: ContentModel
    
    @State private var score = 0
    
    var initialNumberOfQuestions: Int {
        switch vm.levelSelected {
        case .easy:
            return 5
        case .normal:
            return 10
        case .expert:
            return 20
        }
    }
    var numberOfMistakes: Int {
        vm.numberOfQuestions - initialNumberOfQuestions
    }
    var mistakesPercentage: Double {
        Double(numberOfMistakes) / Double(initialNumberOfQuestions)
    }
    var title: String {
        switch mistakesPercentage {
        case 0:
            return "Perfect!"
        case 1...30:
            return "Well Done!"
        default:
            return "You can do better!"
        }
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 30) {
                titleView
                scoreView
                Spacer()
                LogoView(animate: .constant(false))
                Spacer()
                button
            }
            .padding()
            .onAppear {
                calculateScore()
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
            .environmentObject(ContentModel())
    }
}

extension ResultView {
    private var titleView: some View {
        Text(title)
            .font(.largeTitle.weight(.semibold))
            .padding(.vertical)
    }
    private var scoreView: some View {
        VStack {
            Text("Score:")
                .font(.title.weight(.semibold))
            Spacer()
            Text("\(score)")
                .font(.system(size: 60, weight: .semibold, design: .default))
            Spacer()
            Text("You made \(numberOfMistakes) mistakes")
                .font(.title3.weight(.semibold))
        }
        .padding(20)
        .frame(height: 200)
        .background(.white)
        .cornerRadius(25)
        .shadow(radius: 3)
    }
    private var button: some View {
        Button {
            vm.playAgain()
        } label: {
            Text("Play Again")
                .asDefaultButton(foregroundColor: .white, backgroundColor: .theme.darkBlue)
        }
    }
}

extension ResultView {
    private func calculateScore() {
        var points = Int(100 - mistakesPercentage)
        if points < 0 {
            points = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for i in 1...points {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)/100) {
                    score += 1
                }
            }
        }
    }
}
