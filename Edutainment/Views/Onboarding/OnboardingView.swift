//
//  OnboardingView.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//
import SwiftUI

struct OnboardingView: View {
    @StateObject private var vm = ContentModel()
    
    var body: some View {
        TabView(selection: $vm.onboardingPageSelected) {
            MultiplicationSelectionView(vm: vm)
                .tag(0)
            
            LevelSelectionView(vm: vm)
                .tag(1)
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
