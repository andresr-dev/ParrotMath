//
//  OnboardingView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//
import SwiftUI

struct OnboardingView: View {
    @State private var settingShowing: TypeOfSetting = .tables
    
    var body: some View {
        TabView(selection: $settingShowing) {
            MultiplicationSelectionView(settingShowing: $settingShowing)
                .tag(TypeOfSetting.tables)
            
            LevelSelectionView()
                .tag(TypeOfSetting.levels)
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(ContentModel())
    }
}
