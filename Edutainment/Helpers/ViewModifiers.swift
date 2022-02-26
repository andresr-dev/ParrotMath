//
//  ViewModifiers.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 22/02/22.
//

import Foundation
import SwiftUI

struct DefaultContinueButton: ViewModifier {
    let foregroundColor: Color
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.title2.weight(.semibold))
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(Capsule())
            .shadow(radius: 3)
    }
}
