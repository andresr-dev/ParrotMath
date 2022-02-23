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
    
    @State private var posibleResults = [Int]()
    @State private var resultShowing = 0
    
    var multiplication: String {
        "\(vm.multiplicandSelected) x \(vm.multiplier)"
    }
    var correctAnswer: Int {
        vm.multiplicandSelected * vm.multiplier
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                title
                multiplicationCard
                Spacer()
                buttons
            }
            .padding()
        }
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
    }
    private var multiplicationCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(.white)
                .shadow(radius: 3)
                
            multiplicationView
        }
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .padding(.horizontal, 30)
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
        animateAnswer = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            animateAnswer = false
        }
    }
}
