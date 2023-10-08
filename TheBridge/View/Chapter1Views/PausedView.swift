//
//  PauseView.swift
//  TheBridge
//
//  Created by rsbj on 08/10/23.
//

import SwiftUI

struct PausedView: View {
    
    @AppStorage("pause") var pause: Bool = false
    @AppStorage("volumeMusic") var volumeMusic: Double = 0.5
    @AppStorage("volumeEffects") var volumeEffects: Double = 0.5
    
    @Environment(\.presentationMode) var presentation
    
    @Binding var size: CGSize
    @Binding var showPauseView: Bool
    
    var body: some View {
        ZStack {
            Image("backgroundSettings")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Text("Background sounds")
                    .foregroundColor(.white)
                    .font(.custom("PixelifySans-Regular", size: size.height/16))
                    .multilineTextAlignment(.center)
                    .padding(.bottom,-size.width/220)
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
                .padding(.bottom,size.width/40)
                
                
                Text("Sound effects")
                    .foregroundColor(.white)
                    .font(.custom("PixelifySans-Regular", size: size.height/16))
                    .multilineTextAlignment(.center)
                    .padding(.bottom,-size.width/220)
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
                .padding(.bottom,size.width/20)
                
                
                Button (action: {
                    showPauseView = false
                    pause = false
                }) {
                    ZStack {
                        Image("buttonBgWide")
                            .resizable()
                        Text("Back")
                            .font(.custom("PixelifySans-Regular", size: size.height/14))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: size.width/2.7, height: size.height/7)
                
                Button (action: {
                    presentation.wrappedValue.dismiss()
                    pause = false
                }) {
                    ZStack {
                        Image("buttonBgWide")
                            .resizable()
                        Text("Back to Menu")
                            .font(.custom("PixelifySans-Regular", size: size.height/16))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: size.width/2.7, height: size.height/7)
                
            }.padding(.leading,size.width/3.2)
                .padding(.trailing,size.width/3.2)
        }
    }
}

