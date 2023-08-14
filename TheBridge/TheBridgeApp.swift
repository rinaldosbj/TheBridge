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
            if #available(iOS 16.0, *) {
                NavigationStack {
                    StartView()
                }
            }
            else {
                NavigationView {
                    StartView()
                }
                .navigationViewStyle(.stack)
            }
        }
    }
}
