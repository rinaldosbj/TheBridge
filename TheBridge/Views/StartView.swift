import SwiftUI

struct StartView: View {

    @State var showGame = false
    
    var device = Device.shared
    var player = Player.shared
    
    @AppStorage("chapter") var playerChapter = Player.shared.chapter
    
    var body: some View {
        // if IPad has the current version updated
        GeometryReader{
            geo in
            // Faz aqui dentro oq vai aparecer na tela
            ZStack(alignment: .center){
                Image("background1_1")
                    .resizable()
                    .ignoresSafeArea()
                Color(.black)
                    .ignoresSafeArea()
                    .opacity(0.6)
                VStack(alignment: .center){
                    Spacer().frame(height: geo.size.height/5)
                    Text("The Bridge")
                        .font(.custom("PixelifySans-Regular", size: geo.size.height/6.5))
                        .foregroundColor(.white)
                    
                    HStack {
                        
                        if playerChapter != 1 {
                            Spacer()
                            .frame(width: geo.size.width/14, height: geo.size.height/10)
                            .frame(minWidth: 70, minHeight: 70)
                        }
                        
                        Button(action: {
                            showGame = true
                        },label: {
                            ZStack {
                                Image("buttonBgWide")
                                    .resizable()
                                    .frame(minWidth: 350, minHeight: 70)
                                if playerChapter != 1 {
                                    Text("Continue")
                                        .font(.custom("PixelifySans-Regular", size: geo.size.height/12))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(.white)
                                } else {
                                    Text("Start")
                                        .font(.custom("PixelifySans-Regular", size: geo.size.height/12))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(.white)
                                }
                            }
                        })
                        .frame(width: geo.size.width/2.7, height: geo.size.height/7)
                        .frame(minWidth: 350, minHeight: 70)
                        
                        if playerChapter != 1 {
                            Button(action: {
                                player.resetChapters()
                            }, label: {
                                ZStack {
                                    Image("buttonBgDisable")
                                        .resizable()
                                        .frame(minWidth: 70, minHeight: 70)
                                    Image("reload")
                                        .resizable()
                                        .frame(width: geo.size.width/28, height: geo.size.width/28)
                                }
                            })
                            .frame(width: geo.size.width/14, height: geo.size.height/10)
                            .frame(minWidth: 70, minHeight: 70)
                        }
                    }
                    
                    HStack {
                        NavigationLink(destination: HelpView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                    .frame(minWidth: 70, minHeight: 70)
                                Text("?")
                                    .font(.custom("PixelifySans-Regular", size: geo.size.height/14))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.01)
                            }
                        }
                        .frame(width: geo.size.width/14, height: geo.size.height/10)
                        .frame(minWidth: 70, minHeight: 70)
                        
                        NavigationLink(destination: CreditsView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Image("buttonBgWide")
                                    .resizable()
                                    .frame(minWidth: 200, minHeight: 70)
                                Text("Credits")
                                    .font(.custom("PixelifySans-Regular", size: geo.size.height/16))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.01)
                            }
                        }
                        .frame(width: geo.size.width/4.6, height: geo.size.height/10)
                        .frame(minWidth: 200, minHeight: 70)
                        
                        NavigationLink(destination: {
                            SettingsView().navigationBarBackButtonHidden()
                        }, label: {
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                    .frame(minWidth: 70, minHeight: 70)
                                Image("settings")
                                    .resizable()
                                    .frame(width: geo.size.width/28, height: geo.size.width/28)
                            }
                        })
                        .frame(width: geo.size.width/14, height: geo.size.height/10)
                        .frame(minWidth: 70, minHeight: 70)
                        
                    }
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $showGame, onDismiss: {showGame = false}, content: {
                switch playerChapter {
                case 2:
                    ContentView2()
                default:
                    ContentView1()
                }
            })
            .onAppear() {
                player.unpaused()
                device.setSize(width: geo.size.width, heigth: geo.size.height)
            }
        }.ignoresSafeArea()
    }
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
        
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().previewInterfaceOrientation(.landscapeRight)
    }
}

