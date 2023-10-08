import AVFoundation
import SwiftUI
import SpriteKit

extension GameScene1{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let spriteSheetRunRight = [
                SKTexture(imageNamed: "player\(clothes).run.right.f1"),
                SKTexture(imageNamed: "player\(clothes).run.right.f2")]
            let spriteSheetRunLeft = [
                SKTexture(imageNamed: "player\(clothes).run.left.f1"),
                SKTexture(imageNamed: "player\(clothes).run.left.f2")]
            
            let location = touch.location(in: self)
            
            
            if textDidHappened {
                if isNotHappeningAnimation {
                    if !control {
                        if canJump {
                            if location.x >= jumpButton!.frame.minX && location.x <= jumpButton!.frame.maxX && location.y >= jumpButton!.frame.minY && location.y <= jumpButton!.frame.maxY && !isJumping && player!.physicsBody!.velocity.dy <= maxSpeed && (timer-timeJumped) >= 1.5 {
                                // If the user is touching on the jumpButton
                                if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                                    player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: maxSpeed*1.75))
                                    jumpAudio.run(SKAction.play())
                                }
                                else {
                                    player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: maxSpeed))
                                    jumpAudio.run(SKAction.play())
                                }
                                isJumping = true
                                //                light.isEnabled.toggle()
                                timeJumped = timer
                            }
                        }
                        
                        if canMove {
                            if location.x >= leftButton!.frame.minX && location.x <= leftButton!.frame.maxX && location.y >= leftButton!.frame.minY && location.y <= leftButton!.frame.maxY {
                                // If the user is touching on the leftButton
                                isMovinLeft = true
                                player?.run(.repeatForever(.animate(with: spriteSheetRunLeft, timePerFrame: 0.3)))
                                touchForMoved = touch
                            }
                            
                            if location.x >= rightButton!.frame.minX && location.x <= rightButton!.frame.maxX && location.y >= rightButton!.frame.minY && location.y <= rightButton!.frame.maxY {
                                // If the user is touching on the rightButton
                                isMovinRight = true
                                player?.run(.repeatForever(.animate(with: spriteSheetRunRight, timePerFrame: 0.3)))
                                touchForMoved = touch
                            }
                        }
                    }
                    else {
                        if canMove {
                            
                            //                        "Developer Mode"
                            //                        player?.position = location
                            
                            buttonJoystick?.position = location
                            backJoystick?.position = location
                            isclickingJoystick = true
                            player?.removeAllActions()
                        }
                    }
                }
            }
            else {
                if gameStarted {
                    textNumber += 1
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let location = touch.location(in: self)
            
            let spriteSheetRunRight = [
                SKTexture(imageNamed: "player\(clothes).run.right.f1"),
                SKTexture(imageNamed: "player\(clothes).run.right.f2")]
            let spriteSheetRunLeft = [
                SKTexture(imageNamed: "player\(clothes).run.left.f1"),
                SKTexture(imageNamed: "player\(clothes).run.left.f2")]
            
            if textDidHappened {
                if isNotHappeningAnimation {
                if !control {
                    if isMovinLeft && !(location.x >= leftButton!.frame.minX && location.x <= leftButton!.frame.maxX && location.y >= leftButton!.frame.minY && location.y <= leftButton!.frame.maxY) && touch == touchForMoved {
                        // If the user moved his finger out of the leftButton
                        isMovinLeft = false
                    }
                    if isMovinRight && !(location.x >= rightButton!.frame.minX && location.x <= rightButton!.frame.maxX && location.y >= rightButton!.frame.minY && location.y <= rightButton!.frame.maxY) && touch == touchForMoved{
                        // If the user moved his finger out of the rightButton
                        isMovinRight = false
                    }
                }
                    else {
                        if canJump {
                            if location.y < (backJoystick?.position.y)! + 150 && location.y > (backJoystick?.position.y)! - 150 {
                                buttonJoystick?.position.y = location.y
                                if location.y > (backJoystick?.frame.maxY)!-60 {
                                    isclickingJumpJoystick = true
                                    if canJump {
                                        if !isJumping && player!.physicsBody!.velocity.dy <= maxSpeed && (timer-timeJumped) >= 1 {
                                            // If the user is touching on the jumpButton
                                            if (level <= 2 || level >= 5) && !(level == 8 || level == 9) {
                                                player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: maxSpeed*1.75))
                                                jumpAudio.run(SKAction.play())
                                            }
                                            else {
                                                player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: maxSpeed))
                                                jumpAudio.run(SKAction.play())
                                            }
                                            isJumping = true
                                            //                light.isEnabled.toggle()
                                            timeJumped = timer
                                        }
                                    }
                                }
                                else {
                                    isclickingJumpJoystick = false
                                }
                            }
                        }
                        
                        if canMove {
                            if location.x < (backJoystick?.position.x)! + 150 && location.x > (backJoystick?.position.x)! - 150 {
                                buttonJoystick?.position.x = location.x
                                if location.x < ((backJoystick?.frame.midX)!-35) {
                                    if isMovinRight {
                                        player?.removeAllActions()
                                    }
                                    isMovinLeft = true
                                    isMovinRight = false
                                    if !(player?.hasActions())! {
                                        player?.run(.repeatForever(.animate(with: spriteSheetRunLeft, timePerFrame: 0.4)))
                                    }
                                }
                                else if location.x > ((backJoystick?.frame.midX)!+35) {
                                    if isMovinLeft {
                                        player?.removeAllActions()
                                    }
                                    isMovinRight = true
                                    isMovinLeft = false
                                    if !(player?.hasActions())! {
                                        player?.run(.repeatForever(.animate(with: spriteSheetRunRight, timePerFrame: 0.4)))
                                    }
                                }
                                else {
                                    isMovinLeft = false
                                    isMovinRight = false
                                    player?.removeAllActions()
                                    player?.run(.animate(with: [SKTexture(imageNamed: "player\(clothes)")], timePerFrame: 1))
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [self] in
                                        player?.removeAllActions()
                                        player?.physicsBody?.velocity.dx = 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let location = touch.location(in: self)
            
            if textDidHappened && isNotHappeningAnimation {
                canMove = true
                if !(level == 5 || level == 10){
                    canJump = true
                }
                if !control {
                    if location.x >= leftButton!.frame.minX && location.x <= leftButton!.frame.maxX && location.y >= leftButton!.frame.minY && location.y <= leftButton!.frame.maxY && !(leftButton?.isHidden ?? false){
                        isMovinLeft = false
                        player?.removeAllActions()
                    }
                    if location.x >= rightButton!.frame.minX && location.x <= rightButton!.frame.maxX && location.y >= rightButton!.frame.minY && location.y <= rightButton!.frame.maxY && !(rightButton?.isHidden ?? false) {
                        isMovinRight = false
                        player?.removeAllActions()
                    }
                    if !isOnIce && touch == touchForMoved {
                        player?.physicsBody?.velocity.dx = 0
                    }
                }
                else if isclickingJoystick {
                    backJoystick?.position = CGPoint(x: self.frame.maxX-200, y: self.frame.minY+200)
                    buttonJoystick?.position = backJoystick!.position
                    isMovinLeft = false
                    isMovinRight = false
                    player?.removeAllActions()
                    if !isOnIce {
                        player?.physicsBody?.velocity.dx = 0
                    }
                }
                
                isclickingJoystick = false
                isclickingJumpJoystick = false
            }
        }
    }
    
    // for keyboards? dono yet ;-;
    //    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
    //        <#code#>
    //    }
}
