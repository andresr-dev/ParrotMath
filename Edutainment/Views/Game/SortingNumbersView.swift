//
//  ArrangeTheNumbersView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 19/02/22.
//

import SwiftUI

struct SortingNumbersView: View {
    @EnvironmentObject private var vm: ContentModel
    @Namespace private var namespace
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 11, alignment: .center), count: 3)
    let frameHeight: CGFloat = 233
    
    @State private var optionsCharacters = [String]()
    @State private var userAnswer = [String]()
    @State private var rectanglesIdIndices = [Int]()
    @State private var showCharacterInOptions = Array(repeating: true, count: 5)
    @State private var userAnsweredRight: Bool?
    @State private var animateAnswer = false
    @State private var showLogo = false
    @State private var animateLogo = false
    @State private var disableButtons = false
    
    @State private var showWrongAnswerCard = false
    
    var correctAnswer: [[String]] {
        [[
            String(vm.multiplicandSelected),
            "x",
            String(vm.multiplier),
            "=",
            String(vm.multiplicandSelected * vm.multiplier)
        ],
        [
            String(vm.multiplier),
            "x",
            String(vm.multiplicandSelected),
            "=",
            String(vm.multiplicandSelected * vm.multiplier)
        ]]
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                title
                answerBox
                Spacer(minLength: 0)
                if showLogo {
                    logo.transition(.scale.animation(.spring()))
                }
                Spacer(minLength: 0)
                optionsBox
            }
            .padding()
            .padding(.bottom)
            
            if showWrongAnswerCard {
                WrongAnswerCard(
                    multiplication: "\(vm.multiplicandSelected) x \(vm.multiplier)",
                    answer: vm.multiplicandSelected * vm.multiplier)
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .navigationTitle("Question \(vm.currentQuestion)/\(vm.numberOfQuestions)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getOptionsCharacteres()
        }
        .onChange(of: userAnswer) { newValue in
            if newValue.count == optionsCharacters.count {
                checkAnswer()
            }
        }
    }
}

struct SortingNumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SortingNumbersView()
        }
        .environmentObject(ContentModel())
    }
}

extension SortingNumbersView {
    private var title: some View {
        Text("Sort the numbers")
            .font(.largeTitle.weight(.semibold))
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var answerBox: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(radius: 4)
            
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(0..<userAnswer.count, id: \.self) { index in
                    
                    let showCharacterIndex = rectanglesIdIndices[index]
                    if !showCharacterInOptions[showCharacterIndex] {
                        character(
                            text: userAnswer[index],
                            rectangleId: rectanglesIdIndices[index]
                        )
                            .onTapGesture {
                                answerBoxSelected(index: index)
                            }
                            .disabled(disableButtons)
                    }
                }
            }
            .padding()
        }
        .frame(height: frameHeight)
        .padding([.horizontal, .top], 5)
    }
    private var optionsBox: some View {
        LazyVGrid(columns: columns, spacing: 18) {
            ForEach(0..<optionsCharacters.count, id: \.self) { index in
                
                if showCharacterInOptions[index] {
                    character(
                        text: optionsCharacters[index],
                        rectangleId: index
                    )
                        .onTapGesture {
                            optionsBoxSelected(index: index)
                        }
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 0.5)
                        .frame(width: 90, height: 90)
                }
            }
        }
        .padding()
        .frame(height: frameHeight, alignment: .topLeading)
    }
    private func character(text: String, rectangleId: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    userAnsweredRight == nil ? Color.theme.darkBlue :
                        userAnsweredRight! ? Color.green : Color.red
                )
                .animation(.spring(), value: userAnsweredRight)
                .frame(width: 90, height: 90)
            
            Text(text)
                .font(.system(size: 38, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .matchedGeometryEffect(id: rectangleId, in: namespace)
        .scaleEffect(animateAnswer ? 1.1 : 1.0)
        .offset(y: animateAnswer ? -10 : 0)
        .animation(.spring(), value: animateAnswer)
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

extension SortingNumbersView {
    private func getOptionsCharacteres() {
        let correctAnswerShuffled = correctAnswer.first?.shuffled() ?? [""]
        for i in 0..<correctAnswerShuffled.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 + (Double(i)/10 + 0.1)) {
                self.optionsCharacters.append(correctAnswerShuffled[i])
            }
        }
    }
    private func optionsBoxSelected(index: Int) {
        rectanglesIdIndices.append(index)
        userAnswer.append(optionsCharacters[index])
        withAnimation {
            showCharacterInOptions[index] = false
        }
    }
    private func answerBoxSelected(index: Int) {
        withAnimation {
            showCharacterInOptions[rectanglesIdIndices[index]] = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.userAnswer.remove(at: index)
            self.rectanglesIdIndices.remove(at: index)
        }
    }
    private func checkAnswer() {
        disableButtons = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            // Check if user answered right
            if self.correctAnswer.contains(self.userAnswer) {
                self.userAnsweredRight = true
            } else {
                self.userAnsweredRight = false
            }
            // Animate buttons
            self.animateAnswer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animateAnswer = false
            }
            if let userAnsweredRight = self.userAnsweredRight {
                // Save the answer
                vm.saveAnswer(userAnsweredRight: userAnsweredRight)
                // show logo or wrong card
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if userAnsweredRight {
                        showLogo = true
                    } else {
                        withAnimation(.easeInOut) {
                            showWrongAnswerCard = true
                        }
                    }
                }
            }
        }
    }
}
