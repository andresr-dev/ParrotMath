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
    
    @Published var multiplicandSelected = Int.random(in: 2...10)
    @Published var multiplier = Int.random(in: 2...10)
        
    func startGame() {
        withAnimation {
            settingsMode = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onboardingPageSelected = 0
        }
    }
}
