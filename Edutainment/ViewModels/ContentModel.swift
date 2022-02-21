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
    @Published var onboardingPageSelected = 0
    
    var levels = Level.allCases
    @Published var levelSelected: Level = .normal
    
    @Published var multiplicandSelected = 2
    
    // Sorting Game
    var correctAnswerInSortingGame = [[String]]()
    @Published var optionsCharacters = [String]()
    @Published var multiplier = [Int](2...10)
    @Published var userAnswerInSortingGame = [String]()
    @Published var rectanglesIdIndices = [Int]()
    @Published var showCharacterInOptions = Array(repeating: true, count: 5)
    @Published var userAnsweredRightInSortingGame: Bool?
    @Published var animateAnswerInSortingGame = false
    
    func startGame() {
        withAnimation {
            settingsMode = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onboardingPageSelected = 0
        }
    }
    
    // MARK: - SORTING GAME METHODS
    
    func startSortingGame() {
        let randonMultiplier = multiplier.randomElement() ?? 11
        let correctAnswers = [
            [
                String(multiplicandSelected),
                "x",
                String(randonMultiplier),
                "=",
                String(multiplicandSelected * randonMultiplier)
            ],
            [
                String(randonMultiplier),
                "x",
                String(multiplicandSelected),
                "=",
                String(multiplicandSelected * randonMultiplier)
            ]
        ]
        correctAnswerInSortingGame = correctAnswers
        let correctAnswerShuffled = correctAnswerInSortingGame.first?.shuffled() ?? [""]
        for i in 0..<correctAnswerShuffled.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 + (Double(i)/10 + 0.1)) {
                self.optionsCharacters.append(correctAnswerShuffled[i])
            }
        }
    }
    
    func optionsBoxSelected(index: Int) {
        rectanglesIdIndices.append(index)
        userAnswerInSortingGame.append(optionsCharacters[index])
        withAnimation {
            showCharacterInOptions[index] = false
        }
    }
    
    func answerBoxSelected(index: Int) {
        withAnimation {
            showCharacterInOptions[rectanglesIdIndices[index]] = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.userAnswerInSortingGame.remove(at: index)
            self.rectanglesIdIndices.remove(at: index)
        }
    }
    
    func checkAnswerInSortingGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if self.correctAnswerInSortingGame.contains(self.userAnswerInSortingGame) {
                self.userAnsweredRightInSortingGame = true
            } else {
                self.userAnsweredRightInSortingGame = false
            }
            self.animateAnswerInSortingGame = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animateAnswerInSortingGame = false
            }
        }
    }
}
