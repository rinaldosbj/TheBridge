//
//  PauseView.swift
//  TheBridge
//
//  Created by rsbj on 08/10/23.
//

import SwiftUI

struct PausedView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var device = Device.shared
    
    var player = Player.shared
    
    @State var volumeMusic: Double = 0.0
    @State var volumeEffects: Double = 0.0
    
    @Binding var showPauseView: Bool
    
    var body: some View {
        ZStack {
            Image("backgroundSettings")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Text("Background sounds")
                    .foregroundColor(.white)
                    .font(.custom("PixelifySans-Regular", size: device.size.height/16))
                    .multilineTextAlignment(.center)
                    .padding(.bottom,-device.size.width/220)
                HStack{
                    Image("noMusic")
                    UISliderView(value: $volumeMusic,
                                 minValue: 0.0,
                                 maxValue: 1.0,
                                 thumbColor: .white,
                                 minTrackColor: UIColor(named: "lightGray")!,
                                 maxTrackColor: UIColor(named: "darkGray")!)
                    Image("music")
                }
                .padding(.bottom,device.size.width/40)
                
                
                Text("Sound effects")
                    .foregroundColor(.white)
                    .font(.custom("PixelifySans-Regular", size: device.size.height/16))
                    .multilineTextAlignment(.center)
                    .padding(.bottom,-device.size.width/220)
                HStack{
                    Image("noMusic")
                    UISliderView(value: $volumeEffects,
                                 minValue: 0.0,
                                 maxValue: 1.0,
                                 thumbColor: .white,
                                 minTrackColor: UIColor(named: "lightGray")!,
                                 maxTrackColor: UIColor(named: "darkGray")!)
                    Image("music")
                }
                .padding(.bottom,device.size.width/20)
                
                
                Button (action: {
                    showPauseView = false
                    player.unpaused()
                }) {
                    ZStack {
                        Image("buttonBgWide")
                            .resizable()
                        Text("Back")
                            .font(.custom("PixelifySans-Regular", size: device.size.height/14))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: device.size.width/2.7, height: device.size.height/7)
                
                Button (action: {
                    presentation.wrappedValue.dismiss()
                }) {
                    ZStack {
                        Image("buttonBgWide")
                            .resizable()
                        Text("Back to Menu")
                            .font(.custom("PixelifySans-Regular", size: device.size.height/16))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: device.size.width/2.7, height: device.size.height/7)
                
            }.padding(.leading,device.size.width/3.2)
            .padding(.trailing,device.size.width/3.2)
        }
        .onAppear {
            volumeMusic = player.volumeMusic
            volumeEffects = player.volumeEffects
        }
        .onChange(of: volumeMusic) { newValue in
            player.changeVolumeMusic(newVolume: newValue)
        }
        .onChange(of: volumeEffects) { newValue in
            player.changeVolumeEffects(newVolume: newValue)
        }
    }
}


