//
//  LevelSelectionView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct LevelSelectionView: View {
    @EnvironmentObject private var vm: ContentModel
    @State private var animateLogo = false
    private var levels = Level.allCases
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                title
                Spacer()
                LogoView(animate: $animateLogo)
                Spacer()
                message
                levelButtons
                Spacer()
                Spacer()
                startGameButton
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct LevelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LevelSelectionView()
        }
        .environmentObject(ContentModel())
    }
}

extension LevelSelectionView {
    private var title: some View {
        Text("Math Parrot!")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    private var message: some View {
        Text("Choose a level:")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 15)
    }
    private var levelButtons: some View {
        ForEach(levels, id: \.self) { level in
            Button {
                vm.levelSelected = level
                animateLogo = true
            } label: {
                Text(level.rawValue.capitalized)
                    .asDefaultButton(
                        foregroundColor: vm.levelSelected == level ? .black : .white,
                        backgroundColor: vm.levelSelected == level ? .white : .theme.darkBlue
                    )
            }
        }
    }
    private var startGameButton: some View {
        Button {
            vm.startGame()
        } label: {
            Text("Start Game!")
                .asDefaultButton(foregroundColor: .black, backgroundColor: .white)
        }
    }
}
