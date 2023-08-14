import SwiftUI
import SpriteKit
import AVFoundation

enum ColisionTypes: UInt32 {
    case player = 1
    case floor = 2
    case water = 4
    case finish = 8
    case clothing = 16
    case bridge = 32
}

extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA == player {
            playerCollided(with: nodeB)
        }
        else if nodeB == player {
            playerCollided(with: nodeA)
        }
        if nodeA == water {
            waterCollided(with: nodeB)
        }
        else if nodeB == water {
            waterCollided(with: nodeA)
        }
        
    }
    
    func playerCollided(with node: SKNode){
        
        //        let move = SKAction.move(to: node.position, duration: 0.25)
        
        if node.name == "floor" {
            isJumping = false
            if (player?.frame.minY)! >= node.frame.maxY && control {
                player?.physicsBody?.velocity.dy = 0
            }
            if !(isMovinLeft || isMovinRight) {
                player?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
        }
        
        if node.name == "clothing" {
            canMove = false
            canJump = false
            
            isAbleToLevelUp += 1
            isMovinLeft = false
            isMovinRight = false
            isclickingJoystick = false
            isJumping = false

            player?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            backJoystick?.position = CGPoint(x: self.frame.maxX-200, y: self.frame.minY+200)
            buttonJoystick?.position = backJoystick?.position ?? CGPoint(x: 0, y: 0)
            
            if clothes == 2 {
                cloathingAudio = SKAudioNode(fileNamed: "pant.mp3")
                cloathingAudio.autoplayLooped = false
                addChild(cloathingAudio)
                cloathingAudio.run(SKAction.play())
            }
            else {
                shirtAudio = SKAudioNode(fileNamed: "clothe.mp3")
                shirtAudio.autoplayLooped = false
                addChild(shirtAudio)
                shirtAudio.run(SKAction.play())
            }
            clothes += 1
            player?.removeFromParent()
            player = SKSpriteNode(imageNamed: "player\(clothes)")
            if clothes < 6 {
                if level <= 2 {
                    player?.size = CGSize(width: 90, height: 140)
                }
                else {
                    player?.size = CGSize(width: 67.5, height: 105)
                }
                maxSpeed = CGFloat(player!.size.height * 2.5)
            } else {
                player?.size = CGSize(width: 81, height: 118.5)
                maxSpeed = CGFloat(player!.size.height * 3)
            }
            player?.position = playerLastPosition
            player?.name = "player"
            player?.physicsBody = SKPhysicsBody(circleOfRadius: (player?.size.width)!*0.7)
            player?.physicsBody?.allowsRotation = false
            player?.physicsBody?.affectedByGravity = true
            player?.physicsBody?.categoryBitMask =  ColisionTypes.player.rawValue
            player?.physicsBody?.contactTestBitMask = ColisionTypes.floor.rawValue | ColisionTypes.water.rawValue | ColisionTypes.finish.rawValue | ColisionTypes.clothing.rawValue
            player!.lightingBitMask = 1
            addChild(player ?? SKSpriteNode())
            
            node.removeFromParent()
            
            if level == 2 {
                textDidHappened = false
                textBg?.isHidden = false
                text?.isHidden = false
                isclickingJoystick = false
                isclickingJumpJoystick = false
                buttonJoystick?.position = backJoystick!.position
            }
            if level == 3 && isAbleToLevelUp == 1 {
                textDidHappened = false
                textBg?.isHidden = false
                text?.isHidden = false
                isclickingJoystick = false
                isclickingJumpJoystick = false
                buttonJoystick?.position = backJoystick!.position
            }
        }
        
        if node.name == "finish" {
            if isAbleToLevelUp == 1 {
                isclickingJumpJoystick = false
                isJumping = false
                isMovinLeft = false
                isMovinRight = false
                removeChildren(in: self.children)
                timer = 0
                timeJumped = 0
                level += 1
                if level <= 4 {
                    isAbleToLevelUp = 0
                }
                setup()
                textSetup()
                setupAudio()
                if level == 3 || level == 5 {
                    textDidHappened = false
                    text?.isHidden = false
                    textBg?.isHidden = false
                    if level == 5 {
                        downButton?.isHidden = false
                    }
                }
                if level == 2 {
                    batAudio = SKAudioNode(fileNamed: "bat.mp3")
                    batAudio.autoplayLooped = false
                    addChild(batAudio)
                    batAudio.run(SKAction.play())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                        textDidHappened = false
                        text?.isHidden = false
                        textBg?.isHidden = false
                    }
                }
            }
        }
        
        if node.name == "bridge" {
            if cicle == 1 {
                isMovinRight = false
                isMovinLeft = false
                isclickingJoystick = false
                isclickingJumpJoystick = false
                backJoystick?.isHidden = true
                buttonJoystick?.isHidden = true
                rightButton?.isHidden = true
                leftButton?.isHidden = true
                canMove = false
                let lastPlayerPosition = player?.position
                removeChildren(in: self.children)
                let bg = SKSpriteNode(color: .black, size: self.size)
                bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                addChild(bg)
                player = SKSpriteNode(imageNamed: "player6.run.left.f2")
                player?.size = CGSize(width: 108, height: 158)
                player?.position = lastPlayerPosition!
                player?.physicsBody = SKPhysicsBody(circleOfRadius: (player?.size.width)!*0.7)
                player?.physicsBody?.affectedByGravity = false
                addChild(player!)
                let spriteSheetBreaking = [
                    SKTexture(imageNamed: "Sprite0"),
                    SKTexture(imageNamed: "Sprite1"),
                    SKTexture(imageNamed: "Sprite2"),
                    SKTexture(imageNamed: "Sprite3"),
                    SKTexture(imageNamed: "Sprite4"),
                    SKTexture(imageNamed: "Sprite5")]
                bg.zPosition = -11
                bg.run(.animate(with: spriteSheetBreaking, timePerFrame: 0.7))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [self] in
                    breakAudio = SKAudioNode(fileNamed: "break.mp3")
                    breakAudio.autoplayLooped = false
                    addChild(breakAudio)
                    breakAudio.run(SKAction.play())
                }
                
                let spriteSheetFalling = [
                    SKTexture(imageNamed: "player\(clothes).fall1"),
                    SKTexture(imageNamed: "player\(clothes).fall2")]
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) { [self] in
                    player?.run(.repeatForever(.animate(with: spriteSheetFalling, timePerFrame: 0.3)))
                    self.physicsBody = SKPhysicsBody()
                    player?.physicsBody?.affectedByGravity = true
                    let bg = SKSpriteNode(color: .black, size: self.size)
                    bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                    bg.zPosition = -11
                    addChild(bg)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                    removeChildren(in: self.children)
                    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
                    textDidHappened = false
                    cicle = 2
                    level = 1
                    setup()
                    setupAudio()
                    
                }
            }
            else if cicle == 2 {
                isMovinRight = false
                isMovinLeft = false
                isclickingJoystick = false
                isclickingJumpJoystick = false
                backJoystick?.isHidden = true
                buttonJoystick?.isHidden = true
                rightButton?.isHidden = true
                leftButton?.isHidden = true
                canMove = false
                textDidHappened = false
                textBg?.isHidden = false
                text?.isHidden = false
                downButton?.isHidden = false
                player?.removeAllActions()
                player?.run(.animate(with: [SKTexture(imageNamed: "player\(clothes)")], timePerFrame: 1))
                
            }
        }
    }
    
    func waterCollided(with node: SKNode){
        if node.name == "floor" || node.name == "player" {
            
            let waterDrop = SKSpriteNode()
            let spriteSheetWater = [
                SKTexture(imageNamed: "water1"),
                SKTexture(imageNamed: "water2")]
            
            waterDrop.size = CGSize(width: 160, height: 160)
            waterDrop.position.y = node.position.y + 120
            waterDrop.position.x = node.position.x
            waterDrop.lightingBitMask = 1
            
            water?.run(SKAction.removeFromParent())
            
            addChild(waterDrop)
            
            waterDrop.run(.animate(with: spriteSheetWater, timePerFrame: 0.02))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
                waterDrop.run(SKAction.removeFromParent())
            }
            
            //            let urlString = Bundle.main.path(forResource: "water", ofType: "m4a")
            //            do {
            //            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString!))
            //                audioPlayer.volume = 2
            //                audioPlayer.play()
            //            }
            //            catch{
            //                print("Deu erro ae mané: \(error.localizedDescription)")
            //            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in
                if level == 1 {
                    water = SKSpriteNode(color: .blue, size: CGSize(width: 10, height: 20))
                    water?.position = self.waterSpawnPosition
                    water?.physicsBody = SKPhysicsBody(rectangleOf: water!.size)
                    water?.lightingBitMask = 1
                    water?.physicsBody?.allowsRotation = false
                    water?.physicsBody?.affectedByGravity = true
                    water?.physicsBody?.categoryBitMask =  ColisionTypes.water.rawValue
                    water?.physicsBody?.contactTestBitMask = ColisionTypes.floor.rawValue
                    addChild(water ?? SKSpriteNode())
                }
            }
        }
    }
}
