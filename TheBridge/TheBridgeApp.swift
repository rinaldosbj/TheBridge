//
//  TheBridgeApp.swift
//  TheBridge
//
//  Created by rsbj on 02/05/23.
//

import SwiftUI

@main
struct TheBridgeApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeButtonHiden
                NavigationView {
                    StartView()
                }
                .navigationViewStyle(.stack)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

extension TheBridgeApp {
//  Gambs to Hide the Home button in the app
    var HomeButtonHiden: some View {
        ZStack { Text("")
        if #available(iOS 16.0, *) { Text("")
                    .persistentSystemOverlays(.hidden) }
        }
    }
}
