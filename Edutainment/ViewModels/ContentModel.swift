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
    var correctAnswer = [[String]]()
    @Published var shuffledCharacteres = [String]()
    @Published var userAnswer = [String]()
    @Published var multiplier = Array(2...10)
    
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
        
        correctAnswer.append(contentsOf: correctAnswers)

        shuffledCharacteres = correctAnswer.first?.shuffled() ?? [""]
    }
    
    func boxSelected(index: Int) {
        userAnswer.append(shuffledCharacteres[index])
        shuffledCharacteres.remove(at: index)
    }
}
