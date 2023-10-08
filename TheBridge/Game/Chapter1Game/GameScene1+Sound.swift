import SwiftUI
import SpriteKit

extension GameScene1 {
    
    func setupAudio() {
        if !(cicle == 2 && level == 1) {
            
            jumpAudio = SKAudioNode(fileNamed: "jump.mp3")
            jumpAudio.autoplayLooped = false
            addChild(jumpAudio)
            
            if cicle == 2 && level != 1 {
                birdAudio = SKAudioNode(fileNamed: "birds.mp3")
                birdAudio.autoplayLooped = true
                addChild(birdAudio)
                birdAudio.run(SKAction.play())
            }
            
            if level <= 2 || level == 6 || level == 7 {
                // Cave
                backgroundAudio = SKAudioNode(fileNamed: "cave.mp3")
                backgroundAudio.autoplayLooped = true
                addChild(backgroundAudio)
                //            backgroundAudio.run(SKAction.play())
                
                if level == 1 {
                    splashAudio = SKAudioNode(fileNamed: "water.mp3")
                    splashAudio.autoplayLooped = true
                    addChild(splashAudio)
                }
            }
            else {
                // Open world
                backgroundAudio = SKAudioNode(fileNamed: "wind.mp3")
                backgroundAudio.autoplayLooped = true
                addChild(backgroundAudio)
                
                if level == 8 {
                    leavesAudio = SKAudioNode(fileNamed: "leaves.mp3")
                    leavesAudio.autoplayLooped = true
                    addChild(leavesAudio)
                }
            }
        }
    }
}
