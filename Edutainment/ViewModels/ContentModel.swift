//
//  ViewModel.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject {
    
    @Published var settingsMode = true
    @Published var levelSelected: Level = .normal
    @Published var multiplicandSelected = Int.random(in: 2...10)
    
    @Published var numberOfQuestions = 10
    @Published var currentQuestion = 1
    
    private var multiplierOptions = Set<Int>()
    @Published var multiplier = 2
    
    private var userAnswers = [Int:Bool]()
    
    private var typeOfGames: [TypeOfGame] = [.deciding, .sorting, .typing]
    @Published var typeOfGameShowing: TypeOfGame = .deciding
        
    func startGame() {
        multiplierOptions = Set(2...10)
        userAnswers = [Int:Bool]()
        
        switch levelSelected {
        case .easy:
            numberOfQuestions = 5
        case .normal:
            numberOfQuestions = 10
        case .expert:
            numberOfQuestions = 20
        }
        withAnimation {
            settingsMode = false
        }
    }
    
    func newQuestion() {
        if !userAnswers.isEmpty {
            updateTypeOfGameShowing()
            updateNumberOfQuestions()
        }
        updateMultiplier()
    }
    private func updateTypeOfGameShowing() {
        let currentIndex = typeOfGames.firstIndex(of: typeOfGameShowing) ?? 0
        var nextIndex = 0
        if currentIndex < typeOfGames.count - 1 {
            nextIndex += 1
        }
        typeOfGameShowing = typeOfGames[nextIndex]
    }
    private func updateMultiplier() {
        if multiplierOptions.isEmpty {
            let multiplicationsToReview = userAnswers.filter { !$0.value }
            if multiplicationsToReview.count > 0 {
                // There's multiplications to review
                let multipliersToReview = multiplicationsToReview.map { $0.key }
                multiplierOptions = Set(multipliersToReview)
                multiplier = multiplierOptions.randomElement() ?? 0
                multiplierOptions.remove(multiplier)
            } else {
                // There's no multiplications to review so fill multiplier options again
                multiplierOptions = Set(2...10)
                multiplier = multiplierOptions.randomElement() ?? 0
                multiplierOptions.remove(multiplier)
            }
        } else {
            multiplier = multiplierOptions.randomElement() ?? 0
            multiplierOptions.remove(multiplier)
        }
    }
    private func updateNumberOfQuestions() {
        if currentQuestion < numberOfQuestions {
            currentQuestion += 1
        } else {
            currentQuestion = 1
        }
    }
    func saveAnswer(userAnsweredRight: Bool) {
        userAnswers[multiplier] = userAnsweredRight
    }
}
