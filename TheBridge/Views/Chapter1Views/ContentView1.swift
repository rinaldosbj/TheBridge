import SwiftUI
import SpriteKit

struct ContentView1: View {
    
    @State var showChapter1 = true
    @State var title = StringsConstants().TITLECHAPTER1
    @State var text1Animation = false
    @State var showCloseButton = false
    @State var ending = StringsConstants().FIN
    @State var text2Animation = false
    
    @State var scaleValue = 6.0
    @State var positionAnimation = false
    
    @State var showPauseView = false
    @State var showStart = true
    
    @State var isFirst = true
    
    @Environment(\.presentationMode) var presentation
    
    var device = Device.shared
    var player = Player.shared
    
    var scene: SKScene {
        let scene = GameScene1()
        scene.size = CGSize(width: 1920, height: 1280)
        // The experience was design for an ipad thats why the size is fixed
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
        
            .overlay {
                if showStart {
                    startTransition
                }
                
                pauseButton
                
                if showChapter1 {
                    chapterBanner
                }
                
                if showPauseView {
                    PausedView(showPauseView: $showPauseView)
                }
            }
    }
    
}



