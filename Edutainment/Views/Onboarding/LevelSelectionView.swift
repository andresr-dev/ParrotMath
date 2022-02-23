//
//  LevelSelectionView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct LevelSelectionView: View {
    @EnvironmentObject private var vm: ContentModel
    private var levels = Level.allCases
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                title
                Spacer()
                LogoTitleView()
                Spacer()
                message
                levelButtons
                Spacer()
                Spacer()
                continueButton
            }
            .padding()
        }
    }
}

struct LevelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectionView()
            .environmentObject(ContentModel())
    }
}

extension LevelSelectionView {
    private var title: some View {
        Text("Math Parrot")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
    }
    private var message: some View {
        Text("Choose a level:")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 15)
    }
    private var levelButtons: some View {
        ForEach(levels, id: \.self) { level in
            Button {
                vm.levelSelected = level
            } label: {
                Text(level.rawValue.capitalized)
                    .asDefaultButton(
                        foregroundColor: vm.levelSelected == level ? .black : .white,
                        backgroundColor: vm.levelSelected == level ? .white : .theme.darkBlue
                    )
            }
        }
    }
    private var continueButton: some View {
        Button {
            vm.startGame()
            vm.newQuestion()
        } label: {
            Text("Start Game!")
                .asDefaultButton(foregroundColor: .black, backgroundColor: .white)
        }
    }
}
