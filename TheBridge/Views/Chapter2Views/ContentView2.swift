import SwiftUI
import SpriteKit

struct ContentView2: View {
    
    @State var showChapter1 = true
    @State var text1 = StringsConstants().TITLECHAPTER2
    @State var text1Animation = false
    @State var showCloseButton = false
    @State var text2 = StringsConstants().FIN
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
        ZStack {
            Image("backgroundSettings")
                .resizable()
                .ignoresSafeArea()
            
            Text(StringsConstants().COMINGSOON)
                .font(.custom("PixelifySans-Regular", size: device.size.height/8))
                .foregroundColor(.white)
                .minimumScaleFactor(0.01)
        }
        
            .overlay {
                pauseButton
                
                if showChapter1 {
                    chapterBanner
                }
                
                if showPauseView {
                    PausedView(showPauseView: $showPauseView)
                }
                
            }
            .onAppear {
                if player.didReview { /* Player reviewd */ }
                else {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7.0) {
                        ReviewHandler.requestReview()
                        player.userReviewd()
                    }
                }
            }
    }
    
}



