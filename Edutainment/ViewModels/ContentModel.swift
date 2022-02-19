//
//  ViewModel.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var onboardingPageSelected = 0
    
    @Published var tableSelected = 2
    @Published var levels = ["Easy", "Normal", "Expert"]
    @Published var levelSelected = 1
}
