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
    @State private var animateLogo = false
    @State private var showLogo = false
    @State private var showSadEmoji = false
    
    var numberOfMistakes: Int {
        vm.numberOfQuestions - vm.initialNumberOfQuestions
    }
    var mistakesPercentage: Double {
        (Double(numberOfMistakes) / Double(vm.initialNumberOfQuestions)) * 100
    }
    var title: String {
        switch mistakesPercentage {
        case 0:
            return "Perfect!"
        case 1...50:
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
                if showLogo {
                    logo.transition(.scale.animation(.spring()))
                }
                if showSadEmoji {
                    SadEmojiView(size: 120)
                        .transition(.scale.animation(.easeOut(duration: 1.5)))
                }
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
            .padding(.bottom, 15)
    }
    private var scoreView: some View {
        VStack {
            Text("Score:")
                .font(.largeTitle.weight(.bold))
            Spacer()
            Text("\(score)")
                .font(.system(size: 60, weight: .semibold, design: .default))
            Spacer()
            Text("You made \(numberOfMistakes) \(numberOfMistakes == 1 ? "mistake" : "mistakes")")
                .font(.title2.weight(.semibold))
        }
        .padding(25)
        .frame(maxWidth: .infinity)
        .frame(height: 220)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 3)
        .padding(.horizontal, 20)
    }
    private var button: some View {
        Button {
            withAnimation {
                vm.settingsMode = true
            }
        } label: {
            Text("Play Again!")
                .asDefaultButton(foregroundColor: .white, backgroundColor: .theme.darkBlue)
        }
    }
    private var logo: some View {
        LogoView(animate: $animateLogo)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    animateLogo = true
                }
            }
    }
}

// MARK: - FUNCTIONS
extension ResultView {
    private func calculateScore() {
        var points = Int(100 - mistakesPercentage)
        if points < 0 {
            points = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if points > 0 {
                for i in 0..<points {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)/100) {
                        score += 1
                        if i == points - 1 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if score > 50 {
                                    showLogo = true
                                } else {
                                    showSadEmoji = true
                                }
                            }
                        }
                    }
                }
            } else {
                showSadEmoji = true
            }
        }
    }
}
