//
//  View.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 22/02/22.
//

import Foundation
import SwiftUI

extension View {
    func asDefaultButton(foregroundColor: Color, backgroundColor: Color) -> some View {
        modifier(DefaultContinueButton(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
}
