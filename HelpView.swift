import SwiftUI

struct HelpView: View {

    @Environment(\.presentationMode) var presentation
    var font = UIFont()
    var fontS = UIFont()
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{
                
                Image("backgroundSettings")
                    .resizable()
                    .ignoresSafeArea()
                
                
                VStack {
                    Spacer()
                    Text("Help")
                        .font(Font(font))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.01)
                        .padding(.top, geo.size.width/13)
                    Text("The Bridge is a platform game.\nIn the settings screen you can choose one of the control types, Buttons -recommended for IPad- or Joystick -recommended for Mac-.\nTo advance just go up in the direction of the signs, reflect, restart and enjoy the process.")
                        .font(Font(fontS))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.01)
                        .padding(.top, -geo.size.width/13)
                        .padding(geo.size.width/10)
                    Spacer()
                }.padding(geo.size.width/100)
                
                VStack{
                    HStack{
                        Spacer()
                        Button (action: { presentation.wrappedValue.dismiss() } ){
                            ZStack {
                                Image("buttonBg")
                                    .resizable()
                                Text("X")
                                    .font(Font(fontS))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.01)
                            }
                        }
                        .frame(width: geo.size.width/14, height: geo.size.height/10)
                        .padding(.trailing, geo.size.width/20)
                        .padding(.top, geo.size.height/15)
                    }
                    Spacer()
                }.ignoresSafeArea()
            }
        }
    }
    
    init() {
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        font = UIFont(name: "PixelifySans-Regular", size:  80)!
        fontS = UIFont(name: "PixelifySans-Regular", size:  45)!
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
