//
//  NumberBoxView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 19/02/22.
//

import SwiftUI

struct BoxNumberView: View {
    let text: String
    let rectangleId: Int
    let namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.theme.darkBlue)
                .frame(width: 90, height: 90)
            
            Text(text)
                .font(.system(size: 38, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .matchedGeometryEffect(id: rectangleId, in: namespace)
    }
}

struct BoxNumberView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        BoxNumberView(text: "7", rectangleId: 0, namespace: namespace)
    }
}
