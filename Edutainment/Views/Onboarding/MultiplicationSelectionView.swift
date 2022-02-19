//
//  MultiplicationSelectionView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct MultiplicationSelectionView: View {
    
    @EnvironmentObject var vm: ContentModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 5, alignment: .center), count: 3)
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                title
                Spacer()
                LogoTitleView()
                Spacer()
                message
                tablesGrid
                Spacer()
                continueButton
            }
        }
    }
}

struct MultiplicationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationSelectionView()
            .environmentObject(ContentModel())
            //.preferredColorScheme(.dark)
    }
}

extension MultiplicationSelectionView {
    private var title: some View {
        Text("Math Parrot")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
    }
    private var message: some View {
        Text("Choose a table:")
            .font(.title)
            .fontWeight(.bold)
    }
    private var tablesGrid: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(2..<11) { number in
                Button {
                    vm.multiplicandSelected = number
                } label: {
                    MultiplicationIcon(
                        number: number,
                        backgroundColor: vm.multiplicandSelected == number ? .white : Color.theme.darkBlue,
                        foregroundColor: vm.multiplicandSelected == number ? .black : .white
                    )
                }
            }
        }
        .padding(.horizontal)
    }
    private var continueButton: some View {
        Button {
            withAnimation {
                vm.onboardingPageSelected += 1
            }
        } label: {
            ContinueLabel(text: "Continue")
        }
    }
}
