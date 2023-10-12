import SwiftUI
import SpriteKit

struct ContentView1: View {
    
    @AppStorage("pause") var pause: Bool = false
    @AppStorage("volumeMusic") var volumeMusic: Double = 0.5
    @AppStorage("volumeEffects") var volumeEffects: Double = 0.5
    @AppStorage("finishedChapter1") var finishedChapter1: Bool = false
    
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
    
    var scene: SKScene {
        let scene = GameScene1()
        scene.size = CGSize(width: 1920, height: 1280)
        // The experience was design for an ipad thats why the size is fixed
        scene.scaleMode = .aspectFit
        return scene
    }
    
    @State var size = CGSize()
    
    var body: some View {
        GeometryReader{
            geo in
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .onAppear { size = geo.size }
            
                .overlay {
                    if showStart {
                        startTransition
                    }
                    
                    pauseButton
                    
                    if showChapter1 {
                        chapterBanner
                    }
                    
                    if showPauseView {
                        PausedView(size: $size, showPauseView: $showPauseView)
                    }
                }
                .onChange(of: finishedChapter1) { newValue in
                    presentation.wrappedValue.dismiss()
                }
        }
    }
    
}



