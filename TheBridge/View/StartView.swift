import SwiftUI

struct StartView: View {
    @AppStorage("pause") var pause: Bool = false
    @AppStorage("volumeMusic") var volumeMusic: Double = 1.0
    @AppStorage("volumeEffects") var volumeEffects: Double = 1.0
    @AppStorage("showCredit") var showCredit: Bool = false
    
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
                    
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        ZStack {
                            Image("buttonBgWide")
                                .resizable()
                                .frame(minWidth: 350, minHeight: 70)
                            Text("Start")
                                .font(.custom("PixelifySans-Regular", size: geo.size.height/12))
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: geo.size.width/2.7, height: geo.size.height/7)
                    .frame(minWidth: 350, minHeight: 70)
                    
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
                                    .font(.custom("PixelifySans-Regular", size: geo.size.height/14))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.01)
                            }
                        }
                        .frame(width: geo.size.width/4.6, height: geo.size.height/10)
                        .frame(minWidth: 200, minHeight: 70)
                        
                        
                        NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                    .frame(minWidth: 70, minHeight: 70)
                                Image("settings")
                                    .resizable()
                                    .frame(width: geo.size.width/28, height: geo.size.width/28)
                            }
                        }
                        .isDetailLink(false)
                        .frame(width: geo.size.width/14, height: geo.size.height/10)
                        .frame(minWidth: 70, minHeight: 70)
                        
                    }
                    Spacer()
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
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().previewInterfaceOrientation(.landscapeRight)
    }
}

