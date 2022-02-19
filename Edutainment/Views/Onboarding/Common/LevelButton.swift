//
//  LevelButton.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct LevelButton: View {
    let text: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(height: 65)
            .frame(maxWidth: .infinity)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(Capsule())
            .shadow(radius: 4)
            .padding(.horizontal)
    }
}

struct LevelButton_Previews: PreviewProvider {
    static var previews: some View {
        LevelButton(text: "Normal", backgroundColor: .theme.darkBlue, foregroundColor: .white)
    }
}
