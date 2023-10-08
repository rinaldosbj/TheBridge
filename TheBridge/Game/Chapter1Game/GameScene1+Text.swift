import SwiftUI
import SpriteKit

extension GameScene1 {
    
    func textSetup() {
        textBg = SKSpriteNode(imageNamed: "textbg")
        textBg?.size = CGSize(width: 1680, height: 440)
        textBg?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 320)
        textBg?.zPosition = 20
        textBg?.isHidden = true
        addChild(textBg!)
        
        text = SKLabelNode(fontNamed: "PixelifySans-Regular")
        text?.horizontalAlignmentMode = .center
        text?.position = textBg!.position
        text?.fontSize = 80
        text?.zPosition = 21
        text?.numberOfLines = 0
        text?.preferredMaxLayoutWidth = 1600
        text?.lineBreakMode = .byCharWrapping
        text?.verticalAlignmentMode = .center
        text?.isHidden = true
        if level == 1 && clothes == 1 {
            text?.isHidden = false

        }
        addChild(text!)
        
        downButton = SKSpriteNode(imageNamed: "downbutton")
        downButton?.size = CGSize(width: 90, height: 90)
        downButton?.position = CGPoint(x: textBg!.frame.maxX - 100, y: textBg!.frame.minY + 80)
        downButton?.zPosition = 21
        downButton?.isHidden = true
        addChild(downButton!)
    }
}
