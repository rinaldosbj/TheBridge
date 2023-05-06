import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            
            NavigationView {
                StartView()
            }.navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}
