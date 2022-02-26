//
//  ContentView.swift
//  Edutainment
//
//  Created by Andres on 19/02/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ContentModel
    
    var body: some View {
        if vm.settingsMode {
            OnboardingView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading))
                )
        }
        if !vm.settingsMode {
            if vm.screenShowing == .decideGame {
                NavigationView {
                    YesOrNoView()
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading))
                )
            }
            if vm.screenShowing == .sortGame {
                NavigationView {
                    SortingNumbersView()
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading))
                )
            }
            if vm.screenShowing == .typeGame {
                NavigationView {
                    TypeAnswerView()
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading))
                )
            }
            if vm.screenShowing == .resultView {
                ResultView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading))
                    )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
