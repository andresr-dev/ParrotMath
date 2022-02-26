//
//  SadEmojiView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 25/02/22.
//

import SwiftUI

struct SadEmojiView: View {
    private let emojis = ["😔", "😫", "😟", "😩"]
    @State private var emojiSelected = ""
    @State private var animate = false
    let size: CGFloat
    
    var body: some View {
        Text(emojiSelected)
            .font(.system(size: size))
            .scaleEffect(animate ? 1.15 : 1.0)
            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
            .shadow(radius: 3)
            .onAppear {
                emojiSelected = emojis.randomElement() ?? "😭"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    animate = true
                }
            }
    }
}

struct SadEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        SadEmojiView(size: 85)
    }
}
