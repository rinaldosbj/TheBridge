//
//  PositionView.swift
//  WWDC23
//
//  Created by rsbj on 14/04/23.
//

import SwiftUI
import SpriteKit

struct PositionView: View {
    @AppStorage("onboarding") var onboarding: Bool = true
    @AppStorage("onboardingDidHappened") var onboardingDidHappened: Bool = false
    @Environment(\.presentationMode) var presentation
    var font = UIFont()
    
    var scene: SKScene {
        let scene = PositionScene()
        scene.size = CGSize(width: 2000, height: 2000)
        scene.scaleMode = .aspectFit
        return scene
    }
    var body: some View {
        ZStack{
            Color(.black).ignoresSafeArea()
        GeometryReader{
            geo in
            ZStack {
                VStack {
                    Text("  This app was developed to be played in the Landscape, please make sure your IPad is in the correct position and click OK")
                        .font(Font(font))
                        .minimumScaleFactor(0.01)
                        .foregroundColor(.white)
                        .padding(geo.size.height/20)
                    SpriteView(scene: scene)
                    Button (action: {
                        onboarding = false
                        onboardingDidHappened = true
                        presentation.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Image("buttonBgWide")
                                .resizable()
                            Text("Ok")
                                .font(Font(font))
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                            
                        }
                    }.frame(width: geo.size.width/2.7, height: geo.size.width/9)
                        .padding(geo.size.height/20)
                }
            }
        }
    }
    }
    init() {
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

        font = UIFont(name: "PixelifySans-Regular", size:  60)!
    }
}


class PositionScene: SKScene {
    
    var ipadNode = SKSpriteNode()
    var spriteSheetIpad = [SKTexture]()
    
    override func didMove(to view: SKView) {
        for i in 1...8 {
            let textureName = "rotateIpad\(i)"
            spriteSheetIpad.append(SKTexture(imageNamed: textureName))
        }
        backgroundColor = .black
        ipadNode = SKSpriteNode(texture: spriteSheetIpad[0], size: self.size)
        ipadNode.position = CGPoint(x: self.frame.midX, y: self.frame.midX)
        addChild(ipadNode)
        ipadNode.run(.repeatForever(.animate(with: spriteSheetIpad, timePerFrame: 0.7)))
    }
    
    
}



struct PositionView_Previews: PreviewProvider {
    static var previews: some View {
        PositionView().previewInterfaceOrientation(.landscapeRight)
    }
}
