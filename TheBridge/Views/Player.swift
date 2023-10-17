//
//  Player.swift
//  TheBridge
//
//  Created by rsbj on 16/10/23.
//

import SwiftUI

enum Control: Int {
    case Button, Joystick
}

class Player {
    
    private var defaults = UserDefaults()
    
    private struct Constants {
        static var chapter = "chapter"
        static var volumeMusic = "volumeMusic"
        static var volumeEffects = "volumeEffects"
        static var control = "control"
    }
    
    var chapter: Int {
        defaults.integer(forKey: Constants.chapter)
    }
    
    func goToNextChapter() {
        let nextChapter = defaults.integer(forKey: Constants.chapter) + 1
        defaults.set(nextChapter, forKey: Constants.chapter)
    }
    
    var isPaused: Bool = false
    
    func paused() {
        isPaused = true
    }
    
    func unpaused() {
        isPaused = false
    }
    
    var volumeMusic: Double {
        defaults.double(forKey: Constants.volumeMusic)
    }
    
    func changeVolumeMusic(newVolume: Double) {
        defaults.set(newVolume, forKey: Constants.volumeMusic)
    }
    
    var volumeEffects: Double {
        defaults.double(forKey: Constants.volumeEffects)
    }
    
    func changeVolumeEffects(newVolume: Double) {
        defaults.set(newVolume, forKey: Constants.volumeEffects)
    }
    
    var controlType: Control {
        let controlInt: Int = defaults.value(forKey: Constants.control) as! Int
        switch controlInt{
        case 1:
            return .Joystick
        default:
            return .Button
        }
    }
    
    func changeControlType(for type: Control) {
        defaults.set(type.rawValue, forKey: Constants.control)
    }
    
}
