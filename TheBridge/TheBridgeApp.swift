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
            NavigationView {
                StartView()
            }
            .navigationViewStyle(.stack)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .persistentSystemOverlays(.hidden)
        }
    }
}
