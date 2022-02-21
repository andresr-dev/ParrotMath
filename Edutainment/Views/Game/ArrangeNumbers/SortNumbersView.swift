//
//  ArrangeTheNumbersView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 19/02/22.
//

import SwiftUI

struct SortNumbersView: View {
    @EnvironmentObject var vm: ContentModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15, alignment: .center), count: 3)
    let frameHeight: CGFloat = 233
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Sort the numbers")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                        .shadow(radius: 4)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(0..<vm.userAnswer.count, id: \.self) { index in
                            
                            if !vm.showBoxInOptions[vm.rectanglesIdAnswer[index]] {
                                
                                BoxNumberView(
                                    text: vm.userAnswer[index],
                                    rectangleId: vm.rectanglesIdAnswer[index],
                                    namespace: namespace
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
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(0..<vm.optionsCharacters.count, id: \.self) { index in
                        
                        if vm.showBoxInOptions[index] {
                            
                            BoxNumberView(
                                text: vm.optionsCharacters[index],
                                rectangleId: index,
                                namespace: namespace
                            )
                                .onTapGesture {
                                    vm.optionsBoxSelected(index: index)
                                }
                        }
                    }
                }
                .padding()
                .frame(height: frameHeight, alignment: .topLeading)
            }
            .padding([.top, .horizontal])
        }
        .onAppear {
            vm.startSortingGame()
        }
    }
}

struct SortNumbersView_Previews: PreviewProvider {
    static var previews: some View {
        SortNumbersView()
            .environmentObject(ContentModel())
    }
}
