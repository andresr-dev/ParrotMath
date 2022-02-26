//
//  ViewModel.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject {
    
    var gameJustStarted = false
    @Published var settingsMode = true
    @Published var multiplicandSelected = Int.random(in: 2...10)
    @Published var levelSelected: Level = .normal
    
    @Published var initialNumberOfQuestions = 10
    @Published var numberOfQuestions = 10
    @Published var currentQuestion = 0
    
    private var multiplierOptions = Set<Int>()
    @Published var multiplier = 2
    private var multipliersToReview = Set<Int>()
    
    private var userAnswers = [Int:Bool]()
    
    private var screens = TypeOfScreen.allCases
    @Published var screenShowing: TypeOfScreen = .decideGame
    private var screenShowingIndex = 0
        
    func startGame() {
        switch levelSelected {
        case .easy:
            initialNumberOfQuestions = 5
        case .normal:
            initialNumberOfQuestions = 10
        case .expert:
            initialNumberOfQuestions = 20
        }
        numberOfQuestions = initialNumberOfQuestions
        multiplierOptions = Set(2...10)
        userAnswers = [Int:Bool]()
        print("[👉🏻] User Answers in starting game: \(userAnswers)")
        multipliersToReview = Set<Int>()
        print("[👉🏻] Multipliers to review in starting game: \(multipliersToReview)")
        screenShowing = .decideGame
        currentQuestion = 0
        screenShowingIndex = 0
        gameJustStarted = true
        withAnimation {
            settingsMode = false
        }
    }
    func showNextScreen() {
        // Check if it's last question
        if currentQuestion == numberOfQuestions {
            // Show result view
            screenShowingIndex = screens.count - 1
        } else {
            // Loop through the first three itmes of screens array
            let currentIndex = screens.firstIndex(of: screenShowing) ?? 0
            if currentIndex < screens.count - 2 {
                screenShowingIndex += 1
            } else {
                screenShowingIndex = 0
            }
        }
        withAnimation {
            screenShowing = screens[screenShowingIndex]
        }
    }
    func updateMultiplier() {
        currentQuestion += 1
        
        if currentQuestion <= initialNumberOfQuestions {
            // Generate random multipliers
            if multiplierOptions.isNotEmpty {
                print("[👉🏻] Multiplier options: \(multiplierOptions)")
                multiplier = multiplierOptions.randomElement() ?? 0
                print("[👉🏻] Multiplier chosen: \(multiplier)")
                multiplierOptions.remove(multiplier)
            } else {
                multiplierOptions = Set(2...10)
                print("[👉🏻] Multiplier options refilled: \(multiplierOptions)")
                multiplier = multiplierOptions.randomElement() ?? 0
                print("[👉🏻] Multiplier chosen: \(multiplier)")
                multiplierOptions.remove(multiplier)
            }
        } else {
            // Set multiplier with multipliers to review
            print("[👉🏻] Multipliers to review: \(multipliersToReview)")
            multiplier = multipliersToReview.randomElement() ?? 0
            print("[👉🏻] Multiplier chosen to review: \(multiplier)")
            multipliersToReview.remove(multiplier)
        }
    }
    func saveAnswer(userAnsweredRight: Bool) {
        userAnswers[multiplier] = userAnsweredRight
        print("[👉🏻] User answers: \(userAnswers)")
        
        let numbersToReview = userAnswers.filter({!$0.value})
        multipliersToReview = Set(numbersToReview.map({$0.key}))
        print("[👉🏻] Multipliers to review: \(multipliersToReview)")
        
        if currentQuestion <= initialNumberOfQuestions {
            numberOfQuestions = initialNumberOfQuestions + multipliersToReview.count
        } else if !userAnsweredRight {
            // We are in review mode
            numberOfQuestions += 1
        }
    }
}
