//
//  Color.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let background = LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.25)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let darkBlue = Color("DarkBlue")
    let redParrot = Color("RedParrot")
}
