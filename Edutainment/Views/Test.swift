//
//  Test.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 23/02/22.
//

import SwiftUI

struct Test: View {
    let number = 20.5
    let number2 = 5.7
    
    var body: some View {
        Text("\(number * number2, specifier: "%.2f")%")
            .font(.largeTitle.weight(.semibold))
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
