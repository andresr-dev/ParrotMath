//
//  Multiplication.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 19/02/22.
//

import Foundation

struct Multiplication: Identifiable {
    let id = UUID().uuidString
    let multiplicand: Int
    let multipier: Int
    let result: Int
}

struct Factor: Identifiable {
    let id = UUID().uuidString
    let number: Int
}
