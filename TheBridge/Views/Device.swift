//
//  Device.swift
//  TheBridge
//
//  Created by rsbj on 16/10/23.
//

import SwiftUI

class Device {
    
    private var defaults = UserDefaults()
    
    private struct Constants {
        static var width = "width"
        static var height = "height"
    }
    
    var size: CGSize {
        let width = defaults.double(forKey: Constants.width)
        let height = defaults.double(forKey: Constants.height)
        return CGSize(width: width, height: height)
    }
    
    func setSize(width: Double, heigth: Double) {
        defaults.set(width, forKey: Constants.width)
        defaults.set(heigth, forKey: Constants.height)
    }
    
}
