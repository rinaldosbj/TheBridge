import SwiftUI

struct SettingsView: View {
    
    @AppStorage("pause") var pause: Bool = false
    @AppStorage("volumeMusic") var volumeMusic: Double = 0.5
    @AppStorage("volumeEffects") var volumeEffects: Double = 0.5
    @AppStorage("control") var control: Bool = false
    @Environment(\.presentationMode) var presentation
    var font = UIFont()
    var fontS = UIFont()
    
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
                        .font(Font(font))
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
                        .font(Font(font))
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
                    
                    HStack{
                        Button (action: {
                            if control {
                                control.toggle()
                            }
                        }) {
                            if control {
                                ZStack {
                                    Image("buttonBgWide")
                                        .resizable()
                                    Text("Buttons")
                                        .font(Font(fontS))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                
                                ZStack {
                                    Image("buttonBgWideDisable")
                                        .resizable()
                                    Text("Buttons")
                                        .font(Font(fontS))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(width: geo.size.width/5.5, height: geo.size.height/14)
                        
                        Button (action: {
                            if !control {
                                control.toggle()
                            }
                        }) {
                            if !control {
                                ZStack {
                                    Image("buttonBgWide")
                                        .resizable()
                                    Text("Joystick")
                                        .font(Font(fontS))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                
                                ZStack {
                                    Image("buttonBgWideDisable")
                                        .resizable()
                                    Text("Joystick")
                                        .font(Font(fontS))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(width: geo.size.width/5.5, height: geo.size.height/14)
                    }
                    .padding(.bottom,geo.size.width/30)
                    
                    Button (action: {
                        presentation.wrappedValue.dismiss()
                        pause = false
                    }) {
                        ZStack {
                            Image("buttonBgWide")
                                .resizable()
                            Text("Save")
                                .font(Font(font))
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

        font = UIFont(name: "PixelifySans-Regular", size:  60)!
        fontS = UIFont(name: "PixelifySans-Regular", size:  30)!
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().previewInterfaceOrientation(.landscapeRight)
    }
}
