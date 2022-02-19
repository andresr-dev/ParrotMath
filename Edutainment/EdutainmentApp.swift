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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
