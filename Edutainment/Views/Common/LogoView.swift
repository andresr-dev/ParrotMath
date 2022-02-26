//
//  LogoTitleView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct LogoView: View {
    @Binding var animate: Bool
    @State private var scale = false
    @State private var rotate = false
    
    var body: some View {
        Image("parrot")
            .resizable()
            .scaledToFit()
            .frame(height: 120)
            .shadow(radius: 3)
            .scaleEffect(scale ? 1.2 : 1.0)
            .rotationEffect(.degrees(rotate ? 360 : 0))
            .animation(.interpolatingSpring(stiffness: 30, damping: 10), value: scale)
            .onChange(of: animate) { _ in
                if animate {
                    animateLogo()
                }
            }
    }
    func animateLogo() {
        scale = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            scale = false
        }
        withAnimation(.interpolatingSpring(stiffness: 30, damping: 9)) {
            rotate = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            rotate = false
            animate = false
        }
    }
}

struct LogoTitleView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(animate: .constant(false))
    }
}
