//
//  LogoTitleView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct LogoTitleView: View {
    
    var body: some View {
        Image("parrot")
            .resizable()
            .scaledToFit()
            .frame(height: 120)
    }
}

struct LogoTitleView_Previews: PreviewProvider {
    static var previews: some View {
        LogoTitleView()
    }
}
