//
//  Enums & Structs.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import Foundation

enum Level: String, CaseIterable {
    case easy, normal, expert
}

enum YesOrNo: String, CaseIterable {
    case yes, no
}

enum TypeOfScreen: CaseIterable {
    case decideGame, sortGame, typeGame, resultView
}

enum TypeOfSetting {
    case tables, levels
}
