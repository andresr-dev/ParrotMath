//
//  ContinueButton.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct ContinueLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.bottom, 20)
    }
}

struct ContinueButton_Previews: PreviewProvider {
    static var previews: some View {
        ContinueLabel(text: "Continue")
    }
}
