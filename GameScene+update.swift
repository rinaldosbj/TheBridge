import SwiftUI
import SpriteKit
import AVFoundation

extension GameScene {
    
    override func update(_ currentTime: TimeInterval) {
        
        timer = timer + 0.02
        
        //      MARK: Player movement functions
        
        // Applies movement to the left if isMovingLeft is true
        if isMovinLeft && player!.physicsBody!.velocity.dx >= -maxSpeed {
            player?.physicsBody?.applyImpulse(CGVector(dx: -maxSpeed/10, dy: 0))
        }
        
        // Applies movement to the right if isMovingRight is true
        if isMovinRight && player!.physicsBody!.velocity.dx <= maxSpeed {
            player?.physicsBody?.applyImpulse(CGVector(dx: maxSpeed/10, dy: 0))
        }
        
        // Makes sure when the player is not moving he is with the right sprite on
        if !(isMovinLeft || isMovinRight) && canMove {
            if !isclickingJoystick {
                player?.run(.animate(with: [SKTexture(imageNamed: "player\(clothes)")], timePerFrame: 1))
            }
        }
        playerLastPosition = player!.position
        
        // Jump function for joystick
        if isclickingJumpJoystick && control {
            if canJump {
                if !isJumping && player!.physicsBody!.velocity.dy <= maxSpeed && (timer-timeJumped) >= 1.5 {
                    // If the user is touching on the jumpButton
                    if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                        isJumping = true
                        player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: maxSpeed*1.75))
                        jumpAudio.run(SKAction.play())
                    }
                    else {
                        isJumping = true
                        player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: maxSpeed))
                        jumpAudio.run(SKAction.play())
                    }
                    //                light.isEnabled.toggle()
                    timeJumped = timer
                }
            }
        }
        
        //      MARK: Cloathing animations
        
        if (cloathing != nil) {
            if !(cloathing!.hasActions()){
                let scale = SKAction.scale(to: 1.21, duration: 1.5)
                let scale2 = SKAction.scale(to: 1, duration: 1.5)
                let sequence = SKAction.sequence([scale,scale2])
                cloathing?.run(.repeatForever(sequence))
            }
        }
        if (cloathing2 != nil) {
            if !(cloathing2!.hasActions()){
                let scale = SKAction.scale(to: 1.21, duration: 1.5)
                let scale2 = SKAction.scale(to: 1, duration: 1.5)
                let sequence = SKAction.sequence([scale,scale2])
                cloathing2?.run(.repeatForever(sequence))
            }
        }
        if !downButton!.isHidden {
            if !(downButton!.hasActions()){
                let scale = SKAction.scale(to: 1.21, duration: 1.5)
                let scale2 = SKAction.scale(to: 1, duration: 1.5)
                let sequence = SKAction.sequence([scale,scale2])
                downButton?.run(.repeatForever(sequence))
            }
        }
        
        //      MARK: Level restricted stuff and Text Manegement
        //      In general used for specific alterations
        
        if level == 1 || level == 6 {
            if !textDidHappened {
                let spriteSheetFloor = [
                    SKTexture(imageNamed: "player\(clothes).floor2"),
                    SKTexture(imageNamed: "player\(clothes).floor3"),
                    SKTexture(imageNamed: "player6.floor4")]
                let spriteSheetUp = [
                    SKTexture(imageNamed: "player\(clothes).up1"),
                    SKTexture(imageNamed: "player\(clothes).up2")]
                
                textBg?.isHidden = false
                downButton?.isHidden = false
                
                if textNumber == 7 {
                    textDidHappened.toggle()
                    textBg?.isHidden = true
                    text?.isHidden = true
                    downButton?.isHidden = true
                    leftButton?.isHidden = false
                    rightButton?.isHidden = false
                    jumpButton?.isHidden = false
                    backJoystick?.isHidden = false
                    buttonJoystick?.isHidden = false
                    canMove = true
                    canJump = true
                }
                if textNumber == 6 || textNumber == 19 || textNumber == 24 || textNumber == 34 || textNumber == 36 {
                    downButton?.isHidden = true
                }
                if textNumber == 20 || textNumber == 25 || (textNumber == 35 && !animationHappend) || textNumber == 37 {
                    textDidHappened.toggle()
                    textBg?.isHidden = true
                    text?.isHidden = true
                    downButton?.isHidden = true
                    if cicle == 2 && textNumber == 20 {
                        canMove = false
                        canJump = false
                        player?.removeAllActions()
                        player?.run(.animate(with: spriteSheetFloor, timePerFrame: 0.6))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { [self] in
                            textNumber += 2
                            textDidHappened.toggle()
                            textBg?.isHidden = false
                            text?.isHidden = false
                            downButton?.isHidden = false
                        }
                    }
                    if cicle == 2 && textNumber == 25 {
                        player?.removeAllActions()
                        player?.run(.animate(with: [SKTexture(imageNamed: "player\(clothes)")], timePerFrame: 1))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                            textNumber += 1
                            textDidHappened.toggle()
                            textBg?.isHidden = false
                            text?.isHidden = false
                            downButton?.isHidden = false
                        }
                    }
                    if cicle == 2 && textNumber == 35 {
            
                        audioPlayer.play()
                        
                        player?.lightingBitMask = 2
                        mustFollow = true
                        light.lightColor = .white
                        player?.run(SKAction.repeatForever(.animate(with: spriteSheetUp, timePerFrame: 0.5)))
                        player!.run(SKAction.sequence([
                            SKAction.run {
                                self.player?.physicsBody?.isDynamic = false
                            },
                            SKAction.moveTo(y: self.self.frame.maxY - 400, duration: 1),
                            SKAction.wait(forDuration: 1.5),
                            SKAction.run { [self] in
                                whiteBall.isHidden = false
                                whiteBall.size = CGSize(width: 1, height: 1)
                                whiteBall.run(SKAction.scale(by: 3000, duration: 1))
                            },
                            SKAction.wait(forDuration: 0.3),
                            SKAction.run { [self] in
                                whiteBall2.isHidden = false
                                whiteBall2.size = CGSize(width: 1, height: 1)
                                whiteBall2.run(SKAction.scale(by: 3000, duration: 1))
                            },
                            SKAction.wait(forDuration: 0.3),
                            SKAction.run { [self] in
                                whiteBall4.isHidden = false
                                whiteBall4.size = CGSize(width: 1, height: 1)
                                whiteBall4.run(SKAction.scale(by: 3000, duration: 1))
                            },
                            SKAction.wait(forDuration: 0.3),
                            SKAction.run { [self] in
                                whiteBall3.isHidden = false
                                whiteBall3.size = CGSize(width: 1, height: 1)
                                whiteBall3.run(SKAction.scale(by: 3000, duration: 1))
                                playerLastPosition = player!.position
                            },
                            SKAction.wait(forDuration: 1.3),
                            SKAction.run { [self] in
                                player?.lightingBitMask = 1
                                mustFollow = false
                                level = 6
                                self.removeChildren(in: self.children)
                                setup()
                                textSetup()
                                setupAudio()
                                addChild(whiteBall)
                                addChild(whiteBall2)
                                addChild(whiteBall3)
                                addChild(whiteBall4)
                                player?.zPosition = 2
                                player?.position = playerLastPosition
                                
                            },
                            SKAction.run { [self] in
                                whiteBall.isHidden = false
                                whiteBall.size = CGSize(width: 3000, height: 3000)
                                whiteBall.run(SKAction.scale(by: 0.0001, duration: 0.15))
                            },
                            SKAction.run { [self] in
                                whiteBall2.isHidden = false
                                whiteBall2.size = CGSize(width: 3000, height: 3000)
                                whiteBall2.run(SKAction.scale(by: 0.0001, duration: 0.3))
                            },
                            SKAction.run { [self] in
                                whiteBall4.isHidden = false
                                whiteBall4.size = CGSize(width: 3000, height: 3000)
                                whiteBall4.run(SKAction.scale(by: 0.0001, duration: 0.45))
                            },
                            SKAction.run { [self] in
                                whiteBall3.isHidden = false
                                whiteBall3.size = CGSize(width: 3000, height: 3000)
                                whiteBall3.run(SKAction.scale(by: 0.0001, duration: 0.6))
                            },
                            SKAction.run { [self] in
                                animationHappend = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                                    birdAudio = SKAudioNode(fileNamed: "birds.mp3")
                                    birdAudio.autoplayLooped = true
                                    addChild(birdAudio)
                                    textDidHappened.toggle()
                                    textBg?.isHidden = false
                                    text?.isHidden = false
                                    downButton?.isHidden = false
                                }
                            },
                        ]))
                    }
                    if cicle == 2 && textNumber == 37 {
                        self.whiteBall.removeFromParent()
                        leftButton?.isHidden = false
                        rightButton?.isHidden = false
                        jumpButton?.isHidden = false
                        canMove = true
                        canJump = true
                    }
                }
                text?.text = scrits.script[textNumber]
            }
        }
        else if level == 2 {
            if !textDidHappened {
                if (textNumber == 8 && isAbleToLevelUp != 1) {
                    textDidHappened.toggle()
                    textBg?.isHidden = true
                    text?.isHidden = true
                    leftButton?.isHidden = false
                    rightButton?.isHidden = false
                    jumpButton?.isHidden = false
                    backJoystick?.isHidden = false
                    buttonJoystick?.isHidden = false
                    canMove = true
                    canJump = true
                }
                else if textNumber == 9 {
                    textDidHappened.toggle()
                    textBg?.isHidden = true
                    text?.isHidden = true
                    backJoystick?.position = CGPoint(x: self.frame.maxX-200, y: self.frame.minY+200)
                    buttonJoystick?.position = backJoystick!.position
                }
                text?.text = scrits.script[textNumber]
            }
        }
        else if level == 3 {
            if !textDidHappened {
                if (textNumber == 10 &&  isAbleToLevelUp != 1) {
                    textDidHappened.toggle()
                    textBg?.isHidden = true
                    text?.isHidden = true
                    leftButton?.isHidden = false
                    rightButton?.isHidden = false
                    jumpButton?.isHidden = false
                    backJoystick?.isHidden = false
                    buttonJoystick?.isHidden = false
                    canMove = true
                    canJump = true
                }
                else if textNumber == 11 {
                    textDidHappened.toggle()
                    textBg?.isHidden = true
                    text?.isHidden = true
                    textNumber += 2
                }
                text?.text = scrits.script[textNumber]
            }
        }
        else if level == 5 {
            if !textDidHappened {
                if textNumber == 14 {
                    downButton?.isHidden = true
                }
                if textNumber == 15 {
                    textDidHappened.toggle()
                    textBg?.isHidden = true
                    text?.isHidden = true
                    leftButton?.isHidden = false
                    rightButton?.isHidden = false
                    jumpButton?.isHidden = false
                    backJoystick?.isHidden = false
                    buttonJoystick?.isHidden = false
                    canMove = true
                }
                text?.text = scrits.script[textNumber]
            }
        }
        
        if level == 10 {
            text?.text = scrits.script[textNumber]
            if textNumber == 39 {
                downButton?.isHidden = true
                
            }
            if textNumber == 40 {
                audioPlayer.play()
                textNumber += 1
                textDidHappened.toggle()
                textBg?.isHidden = true
                text?.isHidden = true
                var spriteSheetWing = [SKTexture]()
                for i in 1...9 {
                    let textureName = "wing\(i)"
                    spriteSheetWing.append(SKTexture(imageNamed: textureName))
                }
                let spriteSheetUp = [
                    SKTexture(imageNamed: "player\(clothes).up1"),
                    SKTexture(imageNamed: "player\(clothes).up2")]
                addChild(whiteBall)
                addChild(whiteBall2)
                addChild(whiteBall3)
                addChild(whiteBall4)
                whiteBall.isHidden = true
                whiteBall2.isHidden = true
                whiteBall3.isHidden = true
                whiteBall4.isHidden = true
                player?.lightingBitMask = 2
                mustFollow = true
                light.lightColor = .white
                isMovinLeft = false
                isMovinRight = false
                
                player?.physicsBody?.isDynamic = false
                
                player?.run(SKAction.repeatForever(.animate(with: spriteSheetUp, timePerFrame: 0.5)))
                player!.run(SKAction.sequence([
                    SKAction.moveTo(y: self.self.frame.maxY - 400, duration: 1),
                    SKAction.wait(forDuration: 1),
                    SKAction.run { [self] in
                        whiteBall.zPosition = 3
                        whiteBall.isHidden = false
                        whiteBall.size = CGSize(width: 1, height: 1)
                        whiteBall.run(SKAction.scale(by: 3500, duration: 1))
                    },
                    SKAction.wait(forDuration: 0.3),
                    SKAction.run { [self] in
                        whiteBall2.zPosition = 3
                        whiteBall2.isHidden = false
                        whiteBall2.size = CGSize(width: 1, height: 1)
                        whiteBall2.run(SKAction.scale(by: 3500, duration: 1))
                    },
                    SKAction.wait(forDuration: 0.3),
                    SKAction.run { [self] in
                        whiteBall4.zPosition = 3
                        whiteBall4.isHidden = false
                        whiteBall4.size = CGSize(width: 1, height: 1)
                        whiteBall4.run(SKAction.scale(by: 3500, duration: 1))
                    },
                    SKAction.wait(forDuration: 0.3),
                    SKAction.run { [self] in
                        whiteBall3.zPosition = 3
                        whiteBall3.isHidden = false
                        whiteBall3.size = CGSize(width: 1, height: 1)
                        whiteBall3.run(SKAction.scale(by: 3000, duration: 1))
                        playerLastPosition = player!.position
                    },
                    SKAction.wait(forDuration: 1.3),
                    SKAction.run { [self] in
                        player?.zPosition = 5
                        wings = SKSpriteNode(imageNamed: "wing1")
                        wings?.size = CGSize(width: 800, height: 400)
                        wings?.zPosition = 4
                        addChild(wings!)
                        wings?.run(.repeatForever(.animate(with: spriteSheetWing, timePerFrame: 0.08)))
                        
                        wingsAudio = SKAudioNode(fileNamed: "wings.mp3")
                        wingsAudio.autoplayLooped = true
                        addChild(wingsAudio)
                        wingsAudio.run(SKAction.play())
                    },
                    SKAction.run { [self] in
                        whiteBall.zPosition = 3
                        whiteBall.isHidden = false
                        whiteBall.size = CGSize(width: 3000, height: 3000)
                        whiteBall.run(SKAction.scale(by: 0.0001, duration: 0.15))
                    },
                    SKAction.run { [self] in
                        whiteBall2.zPosition = 3
                        whiteBall2.isHidden = false
                        whiteBall2.size = CGSize(width: 3000, height: 3000)
                        whiteBall2.run(SKAction.scale(by: 0.0001, duration: 0.3))
                    },
                    SKAction.run { [self] in
                        whiteBall4.zPosition = 3
                        whiteBall4.isHidden = false
                        whiteBall4.size = CGSize(width: 3000, height: 3000)
                        whiteBall4.run(SKAction.scale(by: 0.0001, duration: 0.45))
                    },
                    SKAction.run { [self] in
                        whiteBall3.zPosition = 3
                        whiteBall3.isHidden = false
                        whiteBall3.size = CGSize(width: 3000, height: 3000)
                        whiteBall3.run(SKAction.scale(by: 0.0001, duration: 0.6))
                    },
                    SKAction.wait(forDuration: 4.2),
                    SKAction.run { [self] in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) { [self] in
                            wingsAudio.run(SKAction.stop())
                        }
                        wings?.removeFromParent()
                        wings = SKSpriteNode(imageNamed: "wing7")
                        wings?.size = CGSize(width: 800, height: 400)
                        wings?.zPosition = 4
                        addChild(wings!)
                        player?.run(SKAction.moveTo(y: (player?.position.y)! + 2000, duration: 1))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [self] in
                            self.whiteBall.removeFromParent()
                            self.removeChildren(in: self.children)
                            self.showCredit = true
                        }
                    }
                ]))
            }
        }
        
        if mustFollow {
            light.position = player!.position
        }
        
        wings?.position.x = player!.position.x - 13
        wings?.position.y = (player?.position.y)! + 28
        
        whiteBall.position = player!.position
        whiteBall2.position = player!.position
        whiteBall3.position = player!.position
        whiteBall4.position = player!.position
        
        
        if pause {
            cloathingAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            splashAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            backgroundAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            leavesAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            birdAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            breakAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            fallAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            energyAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            jumpAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            batAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            shirtAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
            wingsAudio.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
        }
        else {
            cloathingAudio.run(SKAction.changeVolume(to: Float(volumeEffects), duration: 0.0))
            shirtAudio.run(SKAction.changeVolume(to: Float(volumeEffects), duration: 0.0))
            splashAudio.run(SKAction.changeVolume(to: Float(volumeMusic), duration: 0.0))
            if level <= 2 || level == 6 || level == 7 {
                backgroundAudio.run(SKAction.changeVolume(to: Float(volumeMusic * 0.4), duration: 0.0))
            }
            else {
                backgroundAudio.run(SKAction.changeVolume(to: Float(volumeMusic), duration: 0.0))
            }
            leavesAudio.run(SKAction.changeVolume(to: Float(volumeMusic), duration: 0.0))
            birdAudio.run(SKAction.changeVolume(to: Float(volumeMusic)*0.4, duration: 0.0))
            breakAudio.run(SKAction.changeVolume(to: Float(volumeMusic)*0.4, duration: 0.0))
            fallAudio.run(SKAction.changeVolume(to: Float(volumeEffects), duration: 0.0))
            energyAudio.run(SKAction.changeVolume(to: Float(volumeEffects), duration: 0.0))
            jumpAudio.run(SKAction.changeVolume(to: Float(volumeEffects), duration: 0.0))
            batAudio.run(SKAction.changeVolume(to: Float(volumeEffects), duration: 0.0))
            wingsAudio.run(SKAction.changeVolume(to: Float(volumeEffects), duration: 0.0))
            audioPlayer.volume = Float(volumeEffects)
        }
    }
}
