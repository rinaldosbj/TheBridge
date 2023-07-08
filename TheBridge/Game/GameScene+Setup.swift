import SwiftUI
import SpriteKit
import AVFoundation

extension GameScene {
    
    func setup() {
        backgroundTexture = [SKTexture]()
        for i in 1...backgroundAtlas[level] {
            let textureName = "background\(level)_\(i)"
            backgroundTexture!.append(SKTexture(imageNamed: textureName))
        }
        background = SKSpriteNode(imageNamed: "background\(level)_1")
        
        background?.size = self.size
        background?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background?.lightingBitMask = 1
        background?.zPosition = -2
        addChild(background!)
        
        if level != 8 {
            background?.run(.repeatForever(SKAction.animate(with: backgroundTexture!, timePerFrame: 0.75)))
        }
        else {
            background?.run(.repeatForever(SKAction.animate(with: backgroundTexture!, timePerFrame: 0.5)))
        }
        
        
        loadMap()
        
        if !control {
            leftButton = SKSpriteNode(imageNamed: "leftButton")
            leftButton?.size = CGSize(width: 200, height: 160)
            leftButton?.position = CGPoint(x: self.frame.minX+120, y: self.frame.minY+96)
            leftButton?.zPosition = 10
            addChild(leftButton!)
            
            rightButton = SKSpriteNode(imageNamed: "rightButton")
            rightButton?.size = CGSize(width: 200, height: 160)
            rightButton?.position = CGPoint(x: self.frame.minX+360, y: self.frame.minY+96)
            rightButton?.zPosition = 10
            addChild(rightButton!)
            
            jumpButton = SKSpriteNode(imageNamed: "jumpButton")
            jumpButton?.size = CGSize(width: 200, height: 160)
            jumpButton?.position = CGPoint(x: self.frame.maxX-120, y: self.frame.minY+96)
            jumpButton?.zPosition = 10
            addChild(jumpButton!)
        }
        else {
            backJoystick = SKSpriteNode(imageNamed: "backJoystick")
            backJoystick?.position = CGPoint(x: self.frame.maxX-200, y: self.frame.minY+200) // !!!
            backJoystick?.size = CGSize(width: 300, height: 300) // !!!
            backJoystick?.zPosition = 15
            addChild(backJoystick!)
            buttonJoystick = SKSpriteNode(imageNamed: "buttonJoystick")
            buttonJoystick?.position = CGPoint(x: self.frame.maxX-200, y: self.frame.minY+200) // !!!
            buttonJoystick?.size = CGSize(width: 130, height: 130) // !!!
            buttonJoystick?.zPosition = 15
            addChild(buttonJoystick!)
        }
        
        if level == 5 {
            if !control {
                jumpButton?.isHidden = true
            }
            canJump = false
            background = SKSpriteNode(imageNamed: "bridge")
            background?.size = self.size
            background?.position = CGPoint(x: self.frame.midX, y: self.frame.midY+16)
            background?.lightingBitMask = 1
            background?.zPosition = 2
            addChild(background!)
        }
        if level == 10 {
            if !control {
                jumpButton?.isHidden = true
            }
            canJump = false
            background = SKSpriteNode(imageNamed: "bridge2")
            background?.size = self.size
            background?.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 80)
            background?.lightingBitMask = 1
            background?.zPosition = 2
            addChild(background!)
        }
        
        if level <= 5 && level != 4 {
            leftButton?.isHidden = true
            rightButton?.isHidden = true
            jumpButton?.isHidden = true
            backJoystick?.isHidden = true
            buttonJoystick?.isHidden = true
            canMove = false
            canJump = false
        }
        
        
        if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
            physicsWorld.gravity = CGVector(dx: 0, dy: -9)
        }
        else {
            physicsWorld.gravity = CGVector(dx: 0, dy: -6.75)
        }
        
    }
    
    func loadMap() {
        if let levelPath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath) {
                let lines = levelString.components(separatedBy: "\n")
                if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                    blockSize = 160
                    fixFloor = 20
                }
                else {
                    blockSize = 120
                    fixFloor = 60
                }
                
                for (row, line) in lines.reversed().enumerated() {
                    for (column, letter) in line.enumerated() {
                        let position = CGPoint(x: (blockSize * column) + (blockSize/2), y: (blockSize * row) + (blockSize/2) + fixFloor)
                        
                        if letter == "x" {
                            // load wall
                            let node = SKSpriteNode(imageNamed: "platform\(level)")
                            node.position = position
                            node.position.y = position.y + CGFloat(blockSize/4)
                            node.size = CGSize(width: blockSize+3, height: blockSize/2)
                            node.name = "floor"
                            node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                            node.lightingBitMask = 1
                            node.physicsBody?.categoryBitMask = ColisionTypes.floor.rawValue
                            node.physicsBody?.isDynamic = false
                            addChild(node)
                        }
                        if letter == "s" {
                            // load wall
                            var node = SKSpriteNode()
                            if level <= 5 {
                                node = SKSpriteNode(imageNamed: "sign1")
                            }
                            else {
                                node = SKSpriteNode(imageNamed: "sign2")
                            }
                            node.size = CGSize(width: Double(blockSize)/1.5, height: Double(blockSize)/1.35)
                            node.position.y = position.y - Double(blockSize)/7.5
                            node.position.x = position.x - Double(blockSize)/8
                            node.lightingBitMask = 1
                            node.zPosition = -1
                            addChild(node)
                        }
                        else if letter == "p" {
                            player = SKSpriteNode(imageNamed: "player\(clothes)")
                            if !(level == 1 && cicle == 2) {
                                if clothes < 6 {
                                    if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                                        player?.size = CGSize(width: 90, height: 140)
                                    }
                                    else {
                                        player?.size = CGSize(width: 67.5, height: 105)
                                    }
                                    maxSpeed = CGFloat(player!.size.height * 2.5)
                                } else {
                                    if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                                        player?.size = CGSize(width: 108, height: 158)
                                        maxSpeed = CGFloat(player!.size.height * 3)
                                    }
                                    else {
                                        player?.size = CGSize(width: 81, height: 118.5)
                                        maxSpeed = CGFloat(player!.size.height*3)
                                    }
                                }
                                player?.position = position
                                player?.name = "player"
                                player?.physicsBody = SKPhysicsBody(circleOfRadius: (player?.size.width)!*0.7)
                                player?.physicsBody?.allowsRotation = false
                                player?.physicsBody?.affectedByGravity = true
                                player?.physicsBody?.categoryBitMask =  ColisionTypes.player.rawValue
                                player?.physicsBody?.contactTestBitMask = ColisionTypes.floor.rawValue | ColisionTypes.water.rawValue | ColisionTypes.finish.rawValue | ColisionTypes.clothing.rawValue | ColisionTypes.bridge.rawValue
                                player!.lightingBitMask = 1
                                addChild(player ?? SKSpriteNode())
                            }
                        }
                        else if letter == "o"{
                            if (level == 1 && cicle == 2){
                                let spriteSheetFalling = [
                                    SKTexture(imageNamed: "player\(clothes).fall1"),
                                    SKTexture(imageNamed: "player\(clothes).fall2")]
                                player = SKSpriteNode(imageNamed: "player\(clothes)")
                                player?.size = CGSize(width: 108, height: 158)
                                maxSpeed = CGFloat(player!.size.height * 2.5)
                                player?.position = position
                                player?.name = "player"
                                player?.physicsBody = SKPhysicsBody(circleOfRadius: (player?.size.width)!*0.7)
                                player?.physicsBody?.allowsRotation = false
                                player?.physicsBody?.affectedByGravity = true
                                player?.physicsBody?.categoryBitMask =  ColisionTypes.player.rawValue
                                player?.physicsBody?.contactTestBitMask = ColisionTypes.floor.rawValue | ColisionTypes.water.rawValue | ColisionTypes.finish.rawValue | ColisionTypes.clothing.rawValue | ColisionTypes.bridge.rawValue
                                player!.lightingBitMask = 1
                                whiteBall.isHidden = true
                                whiteBall2.isHidden = true
                                whiteBall3.isHidden = true
                                whiteBall4.isHidden = true
                                addChild(whiteBall)
                                addChild(whiteBall2)
                                addChild(whiteBall3)
                                addChild(whiteBall4)
                                addChild(player!)
                                player?.run(.repeatForever(.animate(with: spriteSheetFalling, timePerFrame: 0.3)))
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [self] in
                                    fallAudio = SKAudioNode(fileNamed: "fall.mp3")
                                    fallAudio.autoplayLooped = false
                                    addChild(fallAudio)
                                    fallAudio.run(SKAction.play())
                                    player?.removeAllActions()
                                    player?.run(.animate(with: [SKTexture(imageNamed: "player\(clothes).floor1")], timePerFrame: 1))
                                    light.position.x = player!.position.x
                                    light.position.y = player!.position.y - 500
                                    light.zPosition = -2
                                    light.ambientColor = .black
                                    textSetup()
                                    textBg?.isHidden = false
                                    text?.isHidden = false
                                    downButton?.isHidden = false
                                }
                            }
                        }
                        else if letter == "f" {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                                var node = SKSpriteNode()
                                if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                                    node = SKSpriteNode(color: .clear, size: CGSize(width: blockSize*3, height: blockSize))
                                    node.position.x = position.x + CGFloat(blockSize-fixFloor)
                                    node.position.y = position.y + CGFloat(blockSize-fixFloor)-8
                                }
                                else {
                                    node = SKSpriteNode(color: .clear, size: CGSize(width: blockSize*2, height: blockSize))
                                    node.position.x = position.x + CGFloat(blockSize-fixFloor)-40
                                    node.position.y = position.y + CGFloat(blockSize-fixFloor)-48
                                }
                                node.name = "finish"
                                node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width + 4, height: node.size.height))
                                node.physicsBody?.isDynamic = false
                                node.physicsBody?.categoryBitMask =  ColisionTypes.finish.rawValue
                                addChild(node)
                            }
                            
                            if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                                light.position.x = position.x + CGFloat(blockSize-fixFloor)
                                light.position.y = position.y + CGFloat(blockSize-fixFloor)-1
                                lightPosition.x = position.x + CGFloat(blockSize-fixFloor)
                                lightPosition.y = position.y + CGFloat(blockSize-fixFloor)-1
                            }
                            else {
                                light.position.x = position.x + CGFloat(blockSize-fixFloor)-40
                                light.position.y = position.y + CGFloat(blockSize+fixFloor)+41
                                lightPosition.x = position.x + CGFloat(blockSize-fixFloor)-40
                                lightPosition.y = position.y + CGFloat(blockSize+fixFloor)+41
                            }
                            
                            light.falloff = 1
                            light.lightColor = UIColor.white
                            light.ambientColor = .white
                            if level >= 3 {
                                light.ambientColor = .white
                            }
                            addChild(light)
                        }
                        else if letter == "w" {
                            if cicle != 2 {
                                water = SKSpriteNode(color: .blue, size: CGSize(width: 10, height: 20))
                                water?.name = "water"
                                water?.position.x = position.x
                                water?.position.y = position.y + 79 - CGFloat(fixFloor)
                                waterSpawnPosition = water!.position
                                water?.physicsBody = SKPhysicsBody(rectangleOf: water!.size)
                                water?.lightingBitMask = 1
                                water?.physicsBody?.allowsRotation = false
                                water?.physicsBody?.affectedByGravity = true
                                water?.physicsBody?.categoryBitMask =  ColisionTypes.water.rawValue
                                water?.physicsBody?.contactTestBitMask = ColisionTypes.floor.rawValue | ColisionTypes.player.rawValue
                                addChild(water ?? SKSpriteNode())
                            }
                        }
                        else if letter == "c" {
                            cloathing = SKSpriteNode(imageNamed: "clothing\(clothes)")
                            if level <= 2 {
                                cloathing?.size = CGSize(width: 130, height: 130)
                            }
                            else {
                                cloathing?.size = CGSize(width: 97.5, height: 97.5)
                            }
                            cloathing?.position = position
                            cloathing?.name = "clothing"
                            //                            cloathing?.lightingBitMask = 1
                            cloathing?.physicsBody = SKPhysicsBody(rectangleOf: cloathing!.size)
                            cloathing?.physicsBody?.isDynamic = false
                            cloathing?.physicsBody?.allowsRotation = false
                            cloathing?.physicsBody?.categoryBitMask =  ColisionTypes.clothing.rawValue
                            addChild(cloathing!)
                        }
                        else if letter == "b" {
                            cloathing2 = SKSpriteNode(imageNamed: "clothing\(clothes + 1)")
                            if level <= 2 {
                                cloathing2?.size = CGSize(width: 130, height: 130)
                            }
                            else {
                                cloathing2?.size = CGSize(width: 97.50, height: 97.50)
                            }
                            cloathing2?.position = position
                            cloathing2?.name = "clothing"
                            //                            cloathing?.lightingBitMask = 1
                            cloathing2?.physicsBody = SKPhysicsBody(rectangleOf: cloathing!.size)
                            cloathing2?.physicsBody?.isDynamic = false
                            cloathing2?.physicsBody?.allowsRotation = false
                            cloathing2?.physicsBody?.categoryBitMask =  ColisionTypes.clothing.rawValue
                            addChild(cloathing2!)
                            isAbleToLevelUp = -1
                        }
                        if letter == "T" {
                            let node = SKSpriteNode(color: .clear, size: CGSize(width: blockSize, height: blockSize))
                            node.position = position
                            node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                            node.physicsBody?.isDynamic = false
                            addChild(node)
                        }
                        if letter == "t" {
                            let node = SKSpriteNode(color: .clear, size: CGSize(width: blockSize, height: blockSize))
                            node.position = position
                            node.name = "bridge"
                            node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                            node.physicsBody?.isDynamic = false
                            addChild(node)
                            node.physicsBody?.categoryBitMask = ColisionTypes.bridge.rawValue
                        }
                    }
                }
            }
        }
    }
}



//if let levelPath = Bundle.main.path(forResource: "level1", ofType: "txt") {
//    if let levelString = try? String(contentsOfFile: levelPath) {
//        let lines = levelString.components(separatedBy: "\n")
//
//        var blockSize = 160
//        var fixFloor = 20
//
//        for (row, line) in lines.reversed().enumerated() {
//            for (column, letter) in line.enumerated() {
//                let position = CGPoint(x: (blockSize * column) + (blockSize/2), y: (blockSize * row) + (blockSize/2) + fixFloor)
//            }
//        }
//    }
//}
