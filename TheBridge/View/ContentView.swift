import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @AppStorage("pause") var pause: Bool = false
    @AppStorage("volumeMusic") var volumeMusic: Double = 0.5
    @AppStorage("volumeEffects") var volumeEffects: Double = 0.5
    
    @AppStorage("showCredit") var showCredit: Bool = false
    @State var showChapter1 = true
    @State var text1 = String(localized: "Chapter 1")
    @State var text1Animation = false
    @State var showCloseButton = false
    @State var text2 = "Fin."
    @State var text2Animation = false
    
    @State var scaleValue = 6.0
    @State var positionAnimation = false
    
    @State var showPauseView = false
    @State var showStart = true
    
    @State var isFirst = true
    
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
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
                .overlay {
                    if showStart {
                        Image("start")
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                            .scaleEffect(scaleValue)
                            .offset(x: positionAnimation ? 0: (geo.size.height/3), y: positionAnimation ? 0: -(geo.size.height*1.75))
                            .onAppear {
                                if isFirst {
                                    isFirst.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 7.5) { [self] in
                                        withAnimation(.easeInOut(duration: 1.5)) {
                                            scaleValue = 1
                                            positionAnimation = true
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) { [self] in
                                        withAnimation(.easeInOut(duration: 1)) {
                                            showStart = false
                                        }
                                    }
                                }
                            }
                    }
                    
                    VStack {
                        HStack{
                            Spacer()
                            Button(action: {showPauseView = true}) {
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
                                        text1 = String(localized: "The cave")
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                                        showChapter1 = false
                                    }
                                }
                        }
                    }
                    if showPauseView {
                        ZStack {
                            Image("backgroundSettings")
                                .resizable()
                                .ignoresSafeArea()
                            
                            VStack(alignment: .center) {
                                
                                Text("Background sounds")
                                    .foregroundColor(.white)
                                    .font(.custom("PixelifySans-Regular", size: geo.size.height/16))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,-geo.size.width/220)
                                HStack{
                                    Image("noMusic")
                                    UISliderView(value: $volumeMusic,
                                                 minValue: 0.0,
                                                 maxValue: 1.0,
                                                 thumbColor: .white,
                                                 minTrackColor: UIColor(named: "lightGray")!,
                                                 maxTrackColor: UIColor(named: "darkGray")!)
                                    Image("music")
                                }
                                .padding(.bottom,geo.size.width/40)
                                
                                
                                Text("Sound effects")
                                    .foregroundColor(.white)
                                    .font(.custom("PixelifySans-Regular", size: geo.size.height/16))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,-geo.size.width/220)
                                HStack{
                                    Image("noMusic")
                                    UISliderView(value: $volumeEffects,
                                                 minValue: 0.0,
                                                 maxValue: 1.0,
                                                 thumbColor: .white,
                                                 minTrackColor: UIColor(named: "lightGray")!,
                                                 maxTrackColor: UIColor(named: "darkGray")!)
                                    Image("music")
                                }
                                .padding(.bottom,geo.size.width/20)
                                
                                
                                Button (action: {
                                    showPauseView = false
                                    pause = false
                                }) {
                                    ZStack {
                                        Image("buttonBgWide")
                                            .resizable()
                                        Text("Back")
                                            .font(.custom("PixelifySans-Regular", size: geo.size.height/14))
                                            .minimumScaleFactor(0.01)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: geo.size.width/2.7, height: geo.size.height/7)
                                
                                Button (action: {
                                    presentation.wrappedValue.dismiss()
                                    pause = false
                                }) {
                                    ZStack {
                                        Image("buttonBgWide")
                                            .resizable()
                                        Text("Back to Menu")
                                            .font(.custom("PixelifySans-Regular", size: geo.size.height/16))
                                            .minimumScaleFactor(0.01)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: geo.size.width/2.7, height: geo.size.height/7)
                                
                            }.padding(.leading,geo.size.width/3.2)
                                .padding(.trailing,geo.size.width/3.2)
                        }
                    }
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
                                        text2 = String(localized: "Chapter 2")
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                                        text2 = String(localized: "coming soon...")
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
                }
        }
    }
    
}



