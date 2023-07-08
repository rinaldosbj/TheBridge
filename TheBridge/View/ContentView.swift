import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @AppStorage("showCredit") var showCredit: Bool = false
    @State var showView = true
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 1920, height: 1280)
        // The experience was design for an ipad thats why the size is fixed
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink(destination: PauseView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                Image("pause")
                                    .resizable()
                                    .frame(width: geo.size.width/28, height: geo.size.width/28)
                            }
                        }
                        .frame(minWidth: 70,minHeight: 70)
                        .frame(width: geo.size.width/14, height: geo.size.height/10)
                        .padding(.trailing, geo.size.width/40)
                        .padding(.top, geo.size.height/15)
                    }
                    Spacer()
                    NavigationLink("", destination: CreditsView().navigationBarBackButtonHidden(true),isActive: $showCredit)
                }
                if showView {
                    Color(.black).ignoresSafeArea().onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            showView = false
                        }
                    }
                }
            }
        }
    }
    
}

