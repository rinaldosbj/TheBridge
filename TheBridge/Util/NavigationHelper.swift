import SwiftUI
import SpriteKit
import UIKit


/// Heps to dismiss views and popToRoot
struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
    static func popToPreviusView() {
        findNavigationController(viewController: UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }.last?.rootViewController)?
            .popViewController(animated: true)
        
    }
    
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        if let navigationController = viewController as? UINavigationController {
            navigationController.isNavigationBarHidden = true
            return navigationController
        }
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        return nil
    }
}
