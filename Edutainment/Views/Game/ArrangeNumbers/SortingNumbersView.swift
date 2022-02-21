//
//  ArrangeTheNumbersView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 19/02/22.
//

import SwiftUI

struct SortingNumbersView: View {
    @EnvironmentObject var vm: ContentModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15, alignment: .center), count: 3)
    let frameHeight: CGFloat = 233
    
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                title
                answerBox
                Spacer()
                optionsBox
            }
            .padding([.top, .horizontal])
        }
        .onAppear {
            vm.startSortingGame()
        }
        .onChange(of: vm.userAnswerInSortingGame) { userAnswer in
            if userAnswer.count == vm.optionsCharacters.count {
                vm.checkAnswerInSortingGame()
            }
        }
    }
}

struct SortingNumbersView_Previews: PreviewProvider {
    static var previews: some View {
        SortingNumbersView()
            .environmentObject(ContentModel())
    }
}

extension SortingNumbersView {
    private var title: some View {
        Text("Sort the numbers")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
    private var answerBox: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 4)
            
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(0..<vm.userAnswerInSortingGame.count, id: \.self) { index in
                    
                    let showCharacterIndex = vm.rectanglesIdIndices[index]
                    if !vm.showCharacterInOptions[showCharacterIndex] {
                        character(
                            text: vm.userAnswerInSortingGame[index],
                            rectangleId: vm.rectanglesIdIndices[index]
                        )
                            .onTapGesture {
                                vm.answerBoxSelected(index: index)
                            }
                    }
                }
            }
            .padding()
        }
        .frame(height: frameHeight)
    }
    private var optionsBox: some View {
        LazyVGrid(columns: columns, spacing: 18) {
            ForEach(0..<vm.optionsCharacters.count, id: \.self) { index in
                
                if vm.showCharacterInOptions[index] {
                    character(
                        text: vm.optionsCharacters[index],
                        rectangleId: index
                    )
                        .onTapGesture {
                            vm.optionsBoxSelected(index: index)
                        }
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 0.6)
                        .frame(width: 90, height: 90)
                }
            }
        }
        .padding()
        .frame(height: frameHeight, alignment: .topLeading)
    }
    private func character(text: String, rectangleId: Int) -> some View {
        let userAnsweredRight = vm.userAnsweredRightInSortingGame
        return ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    userAnsweredRight == nil ? Color.theme.darkBlue :
                        userAnsweredRight! ? Color.green : Color.red
                )
                .animation(.spring(), value: userAnsweredRight)
                .frame(width: 90, height: 90)
            
            Text(text)
                .font(.system(size: 38, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .matchedGeometryEffect(id: rectangleId, in: namespace)
        .scaleEffect(vm.animateAnswerInSortingGame ? 1.1 : 1.0)
        .offset(y: vm.animateAnswerInSortingGame ? -10 : 0)
        .animation(.spring(),
                   value: vm.animateAnswerInSortingGame)
    }
}
