//
//  YesOrNotView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 22/02/22.
//

import SwiftUI

struct YesOrNoView: View {
    @EnvironmentObject private var vm: ContentModel
    
    private var allOptions = YesOrNo.allCases
    @State private var optionSelected: YesOrNo?
    @State private var userAnsweredRight = false
    @State private var animateAnswer = false
    @State private var animateLogo = false
    
    @State private var posibleResults = [Int]()
    @State private var resultShowing = 0
    @State private var showWrongAnswerCard = false
    
    var multiplication: String {
        "\(vm.multiplicandSelected) x \(vm.multiplier)"
    }
    var correctAnswer: Int {
        vm.multiplicandSelected * vm.multiplier
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                title
                multiplicationCard
                Spacer(minLength: 0)
                if userAnsweredRight {
                    logo.transition(.scale.animation(.spring()))
                }
                Spacer(minLength: 0)
                buttons
            }
            .padding()
            .padding(.bottom, 30)
            
            if showWrongAnswerCard {
                WrongAnswerCard(
                    multiplication: multiplication,
                    answer: correctAnswer)
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .navigationTitle("Question \(vm.currentQuestion)/\(vm.numberOfQuestions)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setProperties()
        }
    }
}

struct YesOrNoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            YesOrNoView()
        }
        .environmentObject(ContentModel())
    }
}

extension YesOrNoView {
    private var title: some View {
        Text("Is this correct?")
            .font(.largeTitle.weight(.semibold))
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var multiplicationCard: some View {
        VStack(spacing: 0) {
            Text(multiplication)
            Text("=")
                .padding(.bottom, 2)
            Text(resultShowing, format: .number)
        }
        .font(.system(size: 57, weight: .semibold, design: .default))
        .padding()
        .padding(.horizontal, 30)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 3)
    }
    private var multiplicationView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(vm.multiplicandSelected, format: .number)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text(" x ")
                Text(vm.multiplier, format: .number)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                
            Text("=")
                .padding(.bottom, 2)
            
            Text(resultShowing, format: .number)
        }
        .font(.system(size: 57, weight: .semibold, design: .default))
    }
    private var buttons: some View {
        ForEach(allOptions, id: \.self) { option in
            Button {
                buttonPressed(option: option)
            } label: {
                Text(option.rawValue.capitalized)
                    .asDefaultButton(
                        foregroundColor: .white,
                        backgroundColor: optionSelected == option ?
                        userAnsweredRight ? Color.theme.green : .red : .theme.darkBlue
                    )
                    .scaleEffect((optionSelected == option && animateAnswer) ? 1.1 : 1.0)
                    .offset(y: (optionSelected == option && animateAnswer) ? -10 : 0)
                    .animation(.spring(), value: animateAnswer)
            }
            .disabled(optionSelected != nil)
        }
    }
    private var logo: some View {
        LogoView(animate: $animateLogo)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    animateLogo = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        vm.newQuestion()
                    }
                }
            }
    }
}

// MARK: - FUNCTIONS

extension YesOrNoView {
    private func setProperties() {
        posibleResults.append(correctAnswer)
        posibleResults.append(correctAnswer + 1)
        posibleResults.append(correctAnswer - 1)
        resultShowing = posibleResults.randomElement() ?? 0
    }
    private func buttonPressed(option: YesOrNo) {
        optionSelected = option
        let correctAnswerIsShowing = correctAnswer == resultShowing
        if correctAnswerIsShowing {
            userAnsweredRight = optionSelected == .yes
        } else {
            userAnsweredRight = optionSelected == .no
        }
        vm.saveAnswer(userAnsweredRight: userAnsweredRight)
        if !userAnsweredRight {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut) {
                    showWrongAnswerCard = true
                }
            }
        }
        animateAnswer = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            animateAnswer = false
        }
    }
}
