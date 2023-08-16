import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @AppStorage("showCredit") var showCredit: Bool = false
    @State var showChapter1 = true
    @State var text1 = "Chapter 1"
    @State var text1Animation = false
    @State var showView = true
    @State var showCloseButton = false
    @State var text2 = "Fin."
    @State var text2Animation = false

    @Environment(\.presentationMode) var presentation
    
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
            if showCredit {
                ZStack {
                    Image("backgroundSettings")
                        .resizable()
                        .ignoresSafeArea()
                    
                    Text(text2)
                        .font(.custom("PixelifySans-Regular", size: geo.size.height/8))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.01)
                        .animation(.easeInOut, value: text2Animation)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                                text2Animation = true
                                text2 = "Chapter 2"
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                                text2 = "coming soon..."
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7.5) { [self] in
                                showCloseButton = true
                            }
                        }
                    
                    if showCloseButton {
                        VStack{
                            HStack{
                                Spacer()
                                Button (action: { presentation.wrappedValue.dismiss() } ){
                                    ZStack {
                                        Image("buttonBg")
                                            .resizable()
                                            .frame(minWidth: 70,minHeight: 70)
                                        Text("X")
                                            .font(.custom("PixelifySans-Regular", size: geo.size.height/14))
                                            .foregroundColor(.white)
                                            .minimumScaleFactor(0.01)
                                    }
                                }
                                .frame(width: geo.size.width/14, height: geo.size.height/10)
                                .frame(minWidth: 70,minHeight: 70)
                                .padding(.trailing, geo.size.width/20)
                                .padding(.top, geo.size.height/15)
                            }
                            Spacer()
                        }.ignoresSafeArea()
                    }
                }
            }
            else {
                if showChapter1 {
                    ZStack {
                        Image("backgroundSettings")
                            .resizable()
                            .ignoresSafeArea()
                        
                        Text(text1)
                            .font(.custom("PixelifySans-Regular", size: geo.size.height/8))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.01)
                            .animation(.easeInOut, value: text1Animation)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                                    text1Animation = true
                                    text1 = "The cave"
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                                    showChapter1 = false
                                }
                            }
                    }
                }
                else {
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
    }
    
}

