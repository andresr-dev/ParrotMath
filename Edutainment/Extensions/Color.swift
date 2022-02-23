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
    let background = LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.06), Color.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let darkBlue = Color("DarkBlue")
    let redParrot = Color("RedParrot")
    let lightBlue = Color("LightBlue")
    let mediumBlue = Color("MediumBlue")
    let green = Color("Green")
}
