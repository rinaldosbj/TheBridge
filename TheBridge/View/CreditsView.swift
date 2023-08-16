import SwiftUI

struct CreditsView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var license = false
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{
                
                Image("backgroundSettings")
                    .resizable()
                    .ignoresSafeArea()
                
                ScrollView{
                    VStack {
                        Spacer().frame(height: geo.size.height/12)
                        Text("Credits")
                            .font(.custom("PixelifySans-Regular", size: geo.size.height/14))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.01)
                        HStack {
                            Link(destination: URL(string: "https://www.instagram.com/rinaldo_sbj/")!, label: {
                                Text("• Creation, Development and Art by Rinaldo da Silva Bento Junior")
                                    .font(Font(.init(.system, size: geo.size.height/20)))
                                    .foregroundColor(.white)
                                    .padding(.top, geo.size.width/1000)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(10000)
                            })
                            Spacer()
                        }
                        HStack{
                            Link(destination: URL(string: "https://heltonyan.itch.io")!, label: {
                                Text("• Sound efects by Helton Yan from itch.io")
                                    .font(Font(.init(.system, size: geo.size.height/20)))
                                    .foregroundColor(.white)
                                    .padding(.top, geo.size.width/1000)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(10000)
                            })
                            Spacer()
                        }
                        HStack{
                            Link(destination: URL(string: "https://fontesk.com/pixelify-sans-typeface/")!, label: {
                                Text("• Custom font: PixelifySans-Regular by Stefie")
                                    .font(Font(.init(.system, size: geo.size.height/20)))
                                    .foregroundColor(.white)
                                    .padding(.top, geo.size.width/1000)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(10000)
                            })
                            Spacer()
                        }

                        
                        if !license {
                            HStack {
                                Button("  Show license ↓", action: {license.toggle()})
                                    .padding(.top,-geo.size.width/200)
                                    .font(Font(.init(.menuTitle, size: geo.size.height/24)))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        else {
                            VStack{
                                HStack {
                                    Button("  Hide license ↑", action: {license.toggle()})
                                        .padding(.top,-geo.size.width/200)
                                        .font(Font(.init(.menuTitle, size: geo.size.height/24)))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                Text("\nCopyright 2022, Stefie Justprince (justprincedesign@gmail.com) This Font Software is licensed under the SIL Open Font License, Version 1.1. This license is copied below, and is also available with a FAQ at: https://scripts.sil.org/OFL\n\n\n-----------------------------------------------------------\nSIL OPEN FONT LICENSE Version 1.1 - 26 February 2007\n-----------------------------------------------------------\n\nPREAMBLE\nThe goals of the Open Font License (OFL) are to stimulate worldwide development of collaborative font projects, to support the font creation efforts of academic and linguistic communities, and to provide a free and open framework in which fonts may be shared and improved in partnership with others.\n\nThe OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. The fonts, including any derivative works, can be bundled, embedded, redistributed and/or sold with any software provided that any reserved names are not used by derivative works. The fonts and derivatives, however, cannot be released under any other type of license. The requirement for fonts to remain under this license does not apply to any document created using the fonts or their derivatives.\n\nDEFINITIONS\n”Font Software” refers to the set of files released by the Copyright Holder(s) under this license and clearly marked as such. This may include source files, build scripts and documentation.\n\n”Reserved Font Name” refers to any names specified as such after the copyright statement(s).\n\n”Original Version” refers to the collection of Font Software components as distributed by the Copyright Holder(s).\n\n”Modified Version” refers to any derivative made by adding to, deleting, or substituting -- in part or in whole -- any of the components of the Original Version, by changing formats or by porting the Font Software to a new environment.\n\n”Author” refers to any designer, engineer, programmer, technical writer or other person who contributed to the Font Software.\n\nPERMISSION & CONDITIONS\nPermission is hereby granted, free of charge, to any person obtaining a copy of the Font Software, to use, study, copy, merge, embed, modify, redistribute, and sell modified and unmodified copies of the Font Software, subject to the following conditions:\n\n1) Neither the Font Software nor any of its individual components, in Original or Modified Versions, may be sold by itself.\n\n2) Original or Modified Versions of the Font Software may be bundled, redistributed and/or sold with any software, provided that each copy contains the above copyright notice and this license. These can be included either as stand-alone text files, human-readable headers or in the appropriate machine-readable metadata fields within text or binary files as long as those fields can be easily viewed by the user.\n\n3) No Modified Version of the Font Software may use the Reserved Font Name(s) unless explicit written permission is granted by the corresponding Copyright Holder. This restriction only applies to the primary font name as presented to the users.\n\n4) The name(s) of the Copyright Holder(s) or the Author(s) of the Font Software shall not be used to promote, endorse or advertise any Modified Version, except to acknowledge the contribution(s) of the Copyright Holder(s) and the Author(s) or with their explicit written permission.\n\n5) The Font Software, modified or unmodified, in part or in whole, must be distributed entirely under this license, and must not be distributed under any other license. The requirement for fonts to remain under this license does not apply to any document created using the Font Software.\n\nTERMINATION\n This license becomes null and void if any of the above conditions are not met.\n\nDISCLAIMER\nTHE FONT SOFTWARE IS PROVIDED ”AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF COPYRIGHT, PATENT, TRADEMARK, OR OTHER RIGHT. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, INCLUDING ANY GENERAL, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF THE USE OR INABILITY TO USE THE FONT SOFTWARE OR FROM OTHER DEALINGS IN THE FONT SOFTWARE.\n")
                                    .font(Font(.init(.menuTitle, size: geo.size.height/26)))
                                    .foregroundColor(.black)
                                    .lineLimit(10000)
                                    .background(.white.opacity(0.3))
                            }
                        }
                        
                        Text("Considerations")
                            .font(.custom("PixelifySans-Regular", size: geo.size.height/14))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.01)
                            .padding(.top,geo.size.width/16)
                        
                        Text("I would like to express my immense satisfaction in doing this game. Delivering it in such a short time and with so little experience, required a lot of effort and dedication. \nWell, my name is Rinaldo Junior, I am neither a designer or an experienced programmer, but like the character, I am on a journey of transformation. Throughout my life, I have faced many obstacles. Coming from a family without many privileges, I had many difficulty accessing a good education. After much effort and willpower from both me and my family, I managed to enter university, which was a great achievement. But after a while, I realized that what I was doing was not what I wanted, I was no longer enjoying the course, it was nothing like I imagined, and I really thought about giving up. \nHowever, last year when I entered the Apple Developer Academy, I discovered my passion for code. It was difficult, but with each attempt, I realized that it was really for me, it was what I wanted to do. At the beginning of this year, after much thought, I finally gathered the courage to start over. After more than three years studying Production Engineering, I talked to my family, dropped out of the course, and started my journey in Computer Science, my passion. It was a turning point, and now I feel like I am on the right path! I feel like I have found myself again. \nWhen I heard about the Student Challenge, I saw the opportunity to tell my story. I had the idea, but the problem was, I had never made a game alone. I even played around with drawing pixel art characters, but I had never done anything on such a large scale, and with so little time. But again, I gathered my strength and decided that I would not be satisfied until I delivered this game. It was really a huge mountain to climb, but it did not discourage me. After all, how many mountains have I already climbed?")
                            .font(Font(.init(.menuTitle, size: geo.size.height/18)))
                            .foregroundColor(.white)
                            .lineLimit(10000)
                            .padding(.top,geo.size.width/200)
                        
//                        HStack{
//                            Image("player6")
//                                .resizable()
//                                .scaledToFit()
//
//                            Image("me")
//                                .resizable()
//                                .scaledToFit()
//                        }.frame(height: geo.size.height/2)
//                            .padding(.top,geo.size.width/200)
                    }
                }.frame(width: geo.size.width - geo.size.width/4.5, height: geo.size.height - geo.size.width/8.5)
                
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
    
    init() {
        let cfURL = Bundle.main.url(forResource: "PixelifySans-Regular", withExtension: "otf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
