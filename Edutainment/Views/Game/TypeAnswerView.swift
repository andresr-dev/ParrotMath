//
//  TypeAnswerView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 22/02/22.
//

import SwiftUI

struct TypeAnswerView: View {
    @EnvironmentObject var vm: ContentModel
    
    @State private var userAnswer = ""
    @State private var userAnsweredRight: Bool?
    @State private var animateAnswer = false
    
    @FocusState private var keyboardIsFocused
    
    var multiplication: String {
        "\(vm.multiplicandSelected) x \(vm.multiplier)"
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.background.ignoresSafeArea()
            
            multiplicationCard
        }
        .navigationTitle("Type the answer")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    checkAnswer()
                    keyboardIsFocused = false
                }
            }
        }
        .onChange(of: userAnswer) { newValue in
            if newValue.count > 3 {
                let array = Array(userAnswer)
                userAnswer = String(array.dropLast())
            }
        }
    }
}

struct TypeAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TypeAnswerView()
        }
        .environmentObject(ContentModel())
    }
}

extension TypeAnswerView {
    private var multiplicationCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .shadow(radius: 3)
            multiplicationView
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .padding(30)
    }
    private var multiplicationView: some View {
        VStack(spacing: 0) {
            Text(multiplication)
                .font(.system(size: 60, weight: .semibold, design: .default))
            
            Text("=")
                .font(.system(size: 60, weight: .semibold, design: .default))
                .padding(.bottom, 15)
            
            TextField("##", text: $userAnswer)
                .padding(7)
                .font(.system(size: 45, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
                .frame(width: 110)
                .background(userAnsweredRight == nil ? .clear : userAnsweredRight! ? .green : .red)
                .foregroundColor(userAnsweredRight == nil ? .black : .white)
                .cornerRadius(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 0.4)
                }
                .padding(.bottom)
                .scaleEffect(animateAnswer ? 1.1 : 1.0)
                .offset(y: animateAnswer ? -10 : 0)
                .animation(.spring(), value: animateAnswer)
                .keyboardType(.numberPad)
                .focused($keyboardIsFocused)
                .disabled(userAnsweredRight != nil)
        }
    }
}

// MARK: - FUNCTIONS

extension TypeAnswerView {
    func checkAnswer() {
        let correctAnswer = vm.multiplicandSelected * vm.multiplier
        userAnsweredRight = Int(userAnswer) == correctAnswer
        animateAnswer = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            animateAnswer = false
        }
    }
}
