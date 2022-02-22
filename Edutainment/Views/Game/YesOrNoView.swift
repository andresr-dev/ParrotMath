//
//  YesOrNotView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 22/02/22.
//

import SwiftUI

struct YesOrNoView: View {
    @EnvironmentObject private var vm: ContentModel
    
    private var allOptions = YesOrNoOption.allCases
    @State private var optionSelected: YesOrNoOption?
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
        ZStack(alignment: .top) {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                multiplicationCard
                Spacer()
                buttons
            }
            .padding(.bottom)
        }
        .navigationTitle("Is this correct?")
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
    private var multiplicationCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(.white)
                .shadow(radius: 3)
            multiplicationView
        }
        .frame(maxWidth: .infinity)
        .frame(height: 265)
        .padding(20)
        .padding(.horizontal, 20)
    }
    private var multiplicationView: some View {
        VStack(spacing: 0) {
            HStack {
                Text(vm.multiplicandSelected, format: .number)
                    .frame(width: 120, alignment: .trailing)
                Spacer()
                Text(" x ")
                Spacer()
                Text(vm.multiplier, format: .number)
                    .frame(width: 120, alignment: .leading)
            }
                
            Text("=")
                .padding(.bottom, 2)
            
            Text(resultShowing, format: .number)
        }
        .font(.system(size: 60, weight: .semibold, design: .default))
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
                        userAnsweredRight ? .green : .red : .theme.darkBlue
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
    private func buttonPressed(option: YesOrNoOption) {
        optionSelected = option
        let correctAnswerIsShowing = correctAnswer == resultShowing
        if correctAnswerIsShowing {
            userAnsweredRight = optionSelected == .yes
        } else {
            userAnsweredRight = optionSelected == .no
        }
        animateAnswer = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            animateAnswer = false
        }
    }
}
