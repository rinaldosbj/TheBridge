//
//  Device.swift
//  TheBridge
//
//  Created by rsbj on 16/10/23.
//

import SwiftUI

class Device {
    
    static var shared = Device()
    
    var size = CGSize(width: 0, height: 0)
    
    func setSize(width: Double, heigth: Double) {
        size = CGSize(width: width, height: heigth)
    }
    
}
