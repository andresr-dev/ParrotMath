//
//  LevelSelectionView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct LevelSelectionView: View {
    @ObservedObject var vm: ContentModel
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 18) {
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
        }
    }
}

struct LevelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectionView(vm: ContentModel())
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
            .font(.title)
            .fontWeight(.bold)
            .padding(.bottom, 5)
    }
    private var levelButtons: some View {
        ForEach(0..<vm.levels.count, id: \.self) { number in
            Button {
                vm.levelSelected = number
            } label: {
                LevelButton(
                    text: vm.levels[number],
                    backgroundColor: vm.levelSelected == number ? .white : .theme.darkBlue,
                    foregroundColor: vm.levelSelected == number ? .black : .white
                )
            }
        }
    }
    private var continueButton: some View {
        Button {
            
        } label: {
            ContinueLabel(text: "Continue")
        }
    }
}
