//
//  MultiplicationSelectionView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

struct MultiplicationSelectionView: View {
    
    @EnvironmentObject var vm: ContentModel
    @Binding var settingShowing: TypeOfSetting
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 5, alignment: .center), count: 3)
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                title
                Spacer(minLength: 0)
                LogoTitleView()
                Spacer(minLength: 0)
                message
                tablesGrid
                Spacer(minLength: 0)
                continueButton
            }
            .padding()
        }
    }
}

struct MultiplicationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationSelectionView(settingShowing: .constant(.tables))
            .environmentObject(ContentModel())
    }
}

extension MultiplicationSelectionView {
    private var title: some View {
        Text("Math Parrot")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.top)
    }
    private var message: some View {
        Text("Choose a table:")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 5)
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
    }
    private var continueButton: some View {
        Button {
            withAnimation {
                settingShowing = .levels
            }
        } label: {
            Text("Continue")
                .asDefaultButton(foregroundColor: .black, backgroundColor: .white)
        }
    }
}
