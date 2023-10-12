//
//  ContentViewComponents.swift
//  TheBridge
//
//  Created by rsbj on 08/10/23.
//

import SwiftUI

extension ContentView1 {
    var startTransition: some View {
        Image("start")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .scaleEffect(scaleValue)
            .offset(x: positionAnimation ? 0: (size.height/3), y: positionAnimation ? 0: -(size.height*1.75))
            .onAppear {
                if isFirst {
                    isFirst.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) { [self] in
                        withAnimation(.easeInOut(duration: 1.5)) {
                            scaleValue = 1
                            positionAnimation = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) { [self] in
                        withAnimation(.easeInOut(duration: 1)) {
                            showStart = false
                        }
                    }
                }
            }
    }
    
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
            
            Text(title)
                .font(.custom("PixelifySans-Regular", size: size.height/8))
                .foregroundColor(.white)
                .minimumScaleFactor(0.01)
                .animation(.easeInOut, value: text1Animation)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                        text1Animation = true
                        title = StringsConstants().CAVE
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                        showChapter1 = false
                    }
                }
        }
    }
}
