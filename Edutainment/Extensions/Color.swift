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
    //let background = LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("MediumBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let background = RadialGradient(gradient: Gradient(colors: [Color("MediumBlue").opacity(0.15), Color("MediumBlue").opacity(0.45)]), center: .topLeading, startRadius: 280, endRadius: 800)
    let darkBlue = Color("DarkBlue")
    let redParrot = Color("RedParrot")
    let lightBlue = Color("LightBlue")
    let mediumBlue = Color("MediumBlue")
    let green = Color("Green")
}
