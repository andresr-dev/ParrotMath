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
                        .frame(height: 235)
                        .shadow(radius: 4)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<vm.userAnswer.count, id: \.self) { index in
                            BoxNumberView(text: vm.userAnswer[index])
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<vm.shuffledCharacteres.count, id: \.self) { index in
                        BoxNumberView(text: vm.shuffledCharacteres[index])
                            .onTapGesture {
                                vm.boxSelected(index: index)
                            }
                    }
                }
            }
            .padding()
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
