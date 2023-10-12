//
//  ContentViewComponents.swift
//  TheBridge
//
//  Created by rsbj on 08/10/23.
//

import SwiftUI

extension ContentView2 {
    var pauseButton: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {showPauseView = true}) {
                    ZStack {
                        Image("buttonBg")
                            .resizable()
                        Image("pause")
                            .resizable()
                            .frame(width: size.width/28, height: size.width/28)
                    }
                }
                .frame(minWidth: 70,minHeight: 70)
                .frame(width: size.width/14, height: size.height/10)
                .padding(.trailing, size.width/40)
                .padding(.top, size.height/15)
            }
            Spacer()
        }
    }
    
    var chapterBanner: some View {
        ZStack {
            Image("backgroundSettings")
                .resizable()
                .ignoresSafeArea()
            
            Text(text1)
                .font(.custom("PixelifySans-Regular", size: size.height/8))
                .foregroundColor(.white)
                .minimumScaleFactor(0.01)
                .animation(.easeInOut, value: text1Animation)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                        text1Animation = true
                        text1 = StringsConstants().FIELD
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                        showChapter1 = false
                    }
                }
        }
    }
    
    var credits: some View {
        ZStack {
            Image("backgroundSettings")
                .resizable()
                .ignoresSafeArea()
            
            Text(text2)
                .font(.custom("PixelifySans-Regular", size: size.height/8))
                .foregroundColor(.white)
                .minimumScaleFactor(0.01)
                .animation(.easeInOut, value: text2Animation)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                        text2Animation = true
                        text2 = StringsConstants().TITLECHAPTER3
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                        text2 = StringsConstants().COMINGSOON
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7.5) { [self] in
                        showCloseButton = true
                    }
                }
            
            if showCloseButton {
                VStack{
                    HStack{
                        Spacer()
                        Button (action: { presentation.wrappedValue.dismiss() } ){
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                    .frame(minWidth: 70,minHeight: 70)
                                Text("X")
                                    .font(.custom("PixelifySans-Regular", size: size.height/14))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.01)
                            }
                        }
                        .frame(width: size.width/14, height: size.height/10)
                        .frame(minWidth: 70,minHeight: 70)
                        .padding(.trailing, size.width/20)
                        .padding(.top, size.height/15)
                    }
                    Spacer()
                }.ignoresSafeArea()
            }
        }
    }
}
