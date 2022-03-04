//
//  EdutainmentApp.swift
//  Edutainment
//
//  Created by Andres camilo Raigoza misas on 18/02/22.
//

import SwiftUI

@main
struct EdutainmentApp: App {
    @StateObject var vm = ContentModel()
    
    init() {
        let appearance =  UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.clear
        //UINavigationBar.appearance().backgroundColor = .secondarySystemBackground
        //UINavigationBar.appearance().compactAppearance = appearance
        //UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(vm)
        }
    }
}
