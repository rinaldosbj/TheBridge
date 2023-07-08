import SwiftUI

struct PauseView: View {
    
    @AppStorage("pause") var pause: Bool = false
    @AppStorage("volumeMusic") var volumeMusic: Double = 0.5
    @AppStorage("volumeEffects") var volumeEffects: Double = 0.5
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        GeometryReader{
            geo in
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
                    .padding(.bottom,geo.size.width/30)
                    
                    
                    Text("Sound effects")
                        .foregroundColor(.white)
                        .font(.custom("PixelifySans-Regular", size: geo.size.height/12))
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
                        presentation.wrappedValue.dismiss()
                        pause = false
                    }) {
                        ZStack {
                            Image("buttonBgWide")
                                .resizable()
                            Text("Back")
                                .font(.custom("PixelifySans-Regular", size: geo.size.height/12))
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: geo.size.width/2.7, height: geo.size.height/7)
                    
                    Button (action: {
                        NavigationUtil.popToRootView()
                        pause = false
                    }) {
                        ZStack {
                            Image("buttonBgWide")
                                .resizable()
                            Text("Back to Menu")
                                .font(.custom("PixelifySans-Regular", size: geo.size.height/12))
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: geo.size.width/2.7, height: geo.size.height/7)
                    
                }.padding(.leading,geo.size.width/3.2)
                    .padding(.trailing,geo.size.width/3.2)
            }
        }
        .onAppear() {
            pause = true
        }
    }
    init() {
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    }
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView().previewInterfaceOrientation(.landscapeRight)
    }
}
