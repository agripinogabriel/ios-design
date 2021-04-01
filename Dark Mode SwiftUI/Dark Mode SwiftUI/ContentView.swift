//
//  ContentView.swift
//  Dark Mode SwiftUI
//
//  Created by Agripino Gabriel on 01/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("theme") private var theme = 0
    @AppStorage("useSystemTheme") private var useSystemTheme = false
        
    private var isDarkMode: Bool {
        return theme == 1
    }
    
    private var prefferedColorScheme: ColorScheme? {
        guard useSystemTheme else {
            return isDarkMode ? .dark : .light
        }
        return nil
    }
    
    var body: some View {
        
        ZStack {
            Color("BackgroundColor")
            
            VStack {
                ZStack {
                    Image("sun")
                        .resizable()
                        .frame(width: isDarkMode ? 0 : 150, height: isDarkMode ? 0 : 150, alignment: .center)
                        .padding()
                        .opacity(isDarkMode ? 0 : 1)
                    
                    Image("moon")
                        .resizable()
                        .frame(width: isDarkMode ? 150 : 0, height: isDarkMode ? 150 : 0, alignment: .center)
                        .padding()
                        .opacity(isDarkMode ? 1 : 0)
                }
                
                Text("Choose a theme")
                    .font(.system(size: 20))
                    .bold()
                    .padding([.bottom], 8)
                
                Text("Light or Dark, choose the one")
                    .font(.system(size: 16))
                
                Text("which fits better for you!")
                    .font(.system(size: 16))
                    .padding([.bottom])
                
                ZStack {
                    Color("SubBackgroundColor")
                    
                    HStack() {
                        Spacer()
                        Text("LIGHT")
                            .font(.system(size: 22))
                            .bold()
                            .foregroundColor(Color("DarkTextColor"))
                            .onTapGesture {
                                guard useSystemTheme else {
                                    theme = 0
                                    return
                                }
                            }
                            .opacity(isDarkMode ? 1 : 0)
                        Spacer()
                        Text("DARK")
                            .font(.system(size: 22))
                            .bold()
                            .foregroundColor(Color("DarkTextColor"))
                            .onTapGesture {
                                guard useSystemTheme else {
                                    theme = 1
                                    return
                                }
                            }
                            .opacity(isDarkMode ? 0 : 1)
                        Spacer()
                    }
                    
                    ZStack {
                        
                        ZStack {
                            Color("AccentColor")
                            
                            HStack() {
                                Spacer()
                                Text(isDarkMode ? "DARK" : "LIGHT")
                                    .font(.system(size: 22))
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .frame(width: 125, height: 50, alignment: .center)
                        .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    }
                    .frame(width: 250, height: 50, alignment: isDarkMode ? .trailing : .leading)
                }
                .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .padding([.bottom])
                .opacity(useSystemTheme ? 0.4 : 1)
                
                Toggle("Use system theme", isOn: $useSystemTheme).opacity(0)
            }
            .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .preferredColorScheme(prefferedColorScheme)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
