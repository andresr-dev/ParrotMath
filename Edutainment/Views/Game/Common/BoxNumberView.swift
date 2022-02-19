//
//  NumberBoxView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 19/02/22.
//

import SwiftUI

struct BoxNumberView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.darkBlue)
                .frame(width: 90, height: 90)
            
            Text(text)
                .font(.system(size: 38, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct BoxNumberView_Previews: PreviewProvider {
    static var previews: some View {
        BoxNumberView(text: "7")
    }
}
