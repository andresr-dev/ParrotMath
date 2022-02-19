//
//  ArrangeTheNumbersView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 19/02/22.
//

import SwiftUI

struct ArrangeNumbersView: View {
    @EnvironmentObject var vm: ContentModel
    
    private var columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 3)
    
    let multiplier = Int.random(in: 2...10)
    
    var characteres: [String] {
        [
            String(vm.multiplicand),
            "x",
            String(multiplier),
            "=",
            String(vm.multiplicand * multiplier)
        ]
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Arrange the numbers")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(height: 250)
                    .shadow(radius: 4)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<5) { index in
                        BoxNumberView(text: characteres[index])
                    }
                }
            }
            .padding()
        }
    }
}

struct ArrangeNumbersView_Previews: PreviewProvider {
    static var previews: some View {
        ArrangeNumbersView()
            .environmentObject(ContentModel())
    }
}
