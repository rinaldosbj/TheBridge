import SwiftUI

struct HelpView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var device = Device.shared
    
    var body: some View {
        ZStack{
            
            Image("backgroundSettings")
                .resizable()
                .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                Text("Help")
                    .font(.custom("PixelifySans-Regular", size: device.size.height/10))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.01)
                    .padding(.top, device.size.width/13)
                Text(String(localized: "Help_label"))
                    .font(Font(.init(.system, size: device.size.height/12)))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.01)
                    .padding(.top, -device.size.width/13)
                    .padding(device.size.width/10)
                Spacer()
            }.padding(device.size.width/100)
            
            VStack{
                HStack{
                    Spacer()
                    Button (action: { presentation.wrappedValue.dismiss() } ){
                        ZStack {
                            Image("buttonBg")
                                .resizable()
                                .frame(minWidth: 70,minHeight: 70)
                            Text("X")
                                .font(.custom("PixelifySans-Regular", size: device.size.height/14))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.01)
                                .frame(minWidth: 70,minHeight: 70)
                        }
                    }
                    .frame(width: device.size.width/14, height: device.size.height/10)
                    .padding(.trailing, device.size.width/20)
                    .padding(.top, device.size.height/15)
                }
                Spacer()
            }.ignoresSafeArea()
        }
    }
    
    init() {
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
