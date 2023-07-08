import SwiftUI

struct StartView: View {
    @AppStorage("pause") var pause: Bool = false
    @AppStorage("volumeMusic") var volumeMusic: Double = 1.0
    @AppStorage("volumeEffects") var volumeEffects: Double = 1.0
    @AppStorage("showCredit") var showCredit: Bool = false
    var font = UIFont()
    var fontS = UIFont()
    var fontSS = UIFont()
    
    var body: some View {
        // if IPad has the current version updated
        GeometryReader{
            geo in
            // Faz aqui dentro oq vai aparecer na tela
            ZStack{
                Image("background1_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                Color(.black)
                    .ignoresSafeArea()
                    .opacity(0.6)
                VStack{
                    Text("The Bridge")
                        .font(Font(font))
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        ZStack {
                            Image("buttonBgWide")
                                .resizable()
                            Text("Start")
                                .font(Font(fontS))
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: geo.size.width/2.7, height: geo.size.height/7)
                    
                    HStack {
                        NavigationLink(destination: HelpView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                Text("?")
                                    .font(Font(fontSS))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.01)
                            }
                        }
                        .frame(width: geo.size.width/14, height: geo.size.height/10)
                        
                        NavigationLink(destination: CreditsView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Image("buttonBgWide")
                                    .resizable()
                                Text("Credits")
                                    .font(Font(fontSS))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.01)
                            }
                        }
                        .frame(width: geo.size.width/4.6, height: geo.size.height/10)
                        
                        
                        NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                Image("settings")
                                    .resizable()
                                    .frame(width: geo.size.width/28, height: geo.size.width/28)
                            }
                        }
                        .isDetailLink(false)
                        .frame(width: geo.size.width/14, height: geo.size.height/10)
                        
                    }
//                    Spacer()
                }
            }
            .onAppear() {
                pause = false
                showCredit = false
            }
        }
    }
    
    init() {
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        font = UIFont(name: "PixelifySans-Regular", size:  180)!
        fontS = UIFont(name: "PixelifySans-Regular", size:  80)!
        fontSS = UIFont(name: "PixelifySans-Regular", size:  55)!
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().previewInterfaceOrientation(.landscapeRight)
    }
}

