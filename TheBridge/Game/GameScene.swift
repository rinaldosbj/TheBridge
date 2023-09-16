import SwiftUI
import SpriteKit
import AVFoundation
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
        
    // MARK: Variables
    
    @AppStorage("pause") var pause: Bool = false
    // Used to mute the Music while the game is paused
    @AppStorage("volumeMusic") var volumeMusic: Double = 0.5
    // Used to change the Music volume
    @AppStorage("volumeEffects") var volumeEffects: Double = 0.5
    // Used to change the Sound Effects volume
    @AppStorage("control") var control: Bool = false
    // Used to define wich kind of control will be used
    @AppStorage("height") var appHeight: Double = 0.0
    
    var level = 10
    // Define the current level the payer is in
    var cicle = 2
    // Define the current cicle the payer is in
    var textDidHappened: Bool = false
    // Used to control the text flow
    var textNumber = 39
    // Used to control the text flow
    var clothes = 6
    // Define the current clothes the payer is wearing
    var timer = 0.0
    // Used for limiting the interval of time that the player can jump
    var timeJumped = 0.0
    // Registers the last time the player jumped
    var timeSoundPlayed = 0.0
    // Registers the last time the stepSound was played
    var blockSize = 160
    // Defines how big the default size of a fraction of the screen is
    var fixFloor = 0
    // Used to fix the base floor so it is as hight as the buttons
    
    var player: SKSpriteNode?
    // Player node, used to show the player
    var cloathing: SKSpriteNode?
    // Cloathing 1, used to show the first cloath to be displayed
    var cloathing2: SKSpriteNode?
    // Cloathing 2, used to show the second cloath to be displayed
    // PS. there is 2 kinds of cloaths so in the map generation the text can differentiate then both
    var playerLastPosition = CGPoint()
    // Used to check if the player is trying to move and can't
    var water: SKSpriteNode?
    // Water taht will be diging from the ceiling on the level 1 and 6
    var waterSpawnPosition = CGPoint()
    // Define were the water will spawn
    var background: SKSpriteNode?
    // Used to display the backgrounds
    var platform: SKSpriteNode?
    // Used to display the platforms
    var jumpButton: SKSpriteNode?
    // Used to make the player jump
    var leftButton: SKSpriteNode?
    // Used to make the player go to the left
    var rightButton: SKSpriteNode?
    // Used to make the player go to the right
    var backJoystick: SKSpriteNode?
    // Back part of the Joystick (static)
    var buttonJoystick: SKSpriteNode?
    // Moving part of the Joystick
    var isclickingJoystick: Bool = false
    // Checks if the user is touching the Joystick
    var isclickingJumpJoystick: Bool = false
    // Checks if the user is jumping using the Joystick
    var light = SKLightNode()
    // Light that effects the blackground, platforms and player
    var audioPlayer = AVAudioPlayer()
    // Used to play the audios ._.
    var textBg: SKSpriteNode?
    // Text box that will be shown behind the text
    var text: SKLabelNode?
    // Text that will tell the history
    var downButton: SKSpriteNode?
    // Button that will be shown in the textbg to show that there is more text to read
    
    var wings: SKSpriteNode?
    
    var isJumping: Bool = false
    // Check if the player jumped or not
    var isMovinLeft: Bool = false
    // Check if the player is moving to the left or not
    var isMovinRight: Bool = false
    // Check if the player is moving to the right or not .-.
    var isOnIce: Bool = false
    // Unused
    var canMove: Bool = true
    // Says if the player can move or not
    var canJump: Bool = true
    // Says if the player can jump or not
    var isAbleToLevelUp = 1
    // Used to anly permit the player go to next level if it collected every cloath in the level
    var lightPosition = CGPoint(x: 0, y: 0)
    var mustFollow = false
    var whiteBall = SKSpriteNode(imageNamed: "circle")
    var whiteBall2 = SKSpriteNode(imageNamed: "circle")
    var whiteBall3 = SKSpriteNode(imageNamed: "circle")
    var whiteBall4 = SKSpriteNode(imageNamed: "circle")
    @AppStorage("showCredit") var showCredit: Bool = false
    var backgroundAtlas = [0,1,1,1,1,21,1,1,4,24,21]
    var backgroundTexture: [SKTexture]?
    var animationHappend = false
    var isNotHappeningAnimation = true
    var gameStarted = false
    
    var cloathingAudio = SKAudioNode()
    var splashAudio = SKAudioNode()
    var backgroundAudio = SKAudioNode()
    var leavesAudio = SKAudioNode()
    var birdAudio = SKAudioNode()
    var breakAudio = SKAudioNode()
    var fallAudio = SKAudioNode()
    var energyAudio = SKAudioNode()
    var jumpAudio = SKAudioNode()
    var batAudio = SKAudioNode()
    var wingsAudio = SKAudioNode()
    var shirtAudio = SKAudioNode()
    
    var touchForMoved = UITouch()
    // Stores the position were the user is touching if its on the buttons or not
    
    var maxSpeed: CGFloat = 0
    // Used to control the player's speed
    
    var font: UIFont?
    // Sets the font for the text
    
    let scrits = Script()
    // Model used to store the text script
    
    // MARK: GameScene fucntions
    
    override func didMove(to view: SKView){
        self.view?.isMultipleTouchEnabled = true
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [self] in
            textSetup()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 11) { [self] in
            gameStarted = true
        }
        setupAudio()
        setFont()
        setup()
        
        let urlString = Bundle.main.path(forResource: "energy", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString!))
            audioPlayer.volume = Float(volumeEffects)
        }
        catch{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    override func willMove(from view: SKView) {
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
    
    func setFont() {
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

        font = UIFont(name: "PixelifySans-Regular", size:  14.0)
    }
    
}

