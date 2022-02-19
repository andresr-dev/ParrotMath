//
//  MultiplicationIcon.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct MultiplicationIcon: View {
    let number: Int
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .shadow(radius: 5)
            
            Text("\(number)x")
                .font(.system(size: 32, weight: .medium, design: .default))
                .fontWeight(.semibold)
                .foregroundColor(foregroundColor)
        }
        .frame(width: 90, height: 90)
    }
}

struct MultiplicationIcon_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationIcon(number: 4, backgroundColor: Color.theme.darkBlue, foregroundColor: .white)
    }
}
