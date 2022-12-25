//
//  WelcomeView.swift
//  CO2 Aware
//
//  Created by 王首之 on 12/20/22.
//

import SwiftUI

//Main welcome screen
struct WelcomeView: View {
    @State private var inAnimation = false
    @State private var buttonIn = false
    @ObservedObject var p :  UserProgress
    var body: some View {
        NavigationView{
            
            VStack {
                Image("Icon")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(40)
                .scaleEffect(inAnimation ? 1: 0, anchor: .bottom)
                
                Text("Welcome!")
                    .font(.largeTitle.weight(.bold))
                    
                .scaleEffect(inAnimation ? 1: 0, anchor: .bottom)
                Spacer()
                    .frame(height: 150)
                
                NavigationLink(destination: Welcome2(p: p)) {
                    Image(systemName: "arrow.right.circle")
                    
                        .font(.largeTitle)
                }
                .scaleEffect(buttonIn ? 1: 0, anchor: .leading)
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            .background(
                Image("HomeLvl3")
                    .resizable()
                    .ignoresSafeArea()
                
                    .padding(-10)
            )
            
            // In animation
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    inAnimation = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation(.easeInOut(duration: 1)) {
                        buttonIn = true
                    }
                    
                }
            }
        }
            }
        
}

// Welcome Screen 2
struct Welcome2: View {
    @ObservedObject var p :  UserProgress
    var body: some View{
        ScrollView{
            VStack(alignment: .leading){
                Text("There is no Planet B.")
                    .font(.title.weight(.bold))
                    .multilineTextAlignment(.leading)
                    
                Spacer()
                Text(.init("***Emissions continue to rise.*** As a result, the Earth is now about 1.1°C warmer than it was in the late 1800s. The last decade (2011-2020) was the warmest on record.\n\nMany people think climate change mainly means warmer temperatures. But temperature rise is only the beginning of the story. Because the Earth is a system, where everything is connected, **changes in one area can influence changes in all others**.\n\nThe consequences of climate change now include, among others, **intense droughts, water scarcity, severe fires, rising sea levels, flooding, melting polar ice, catastrophic storms and declining biodiversity.**"))
                    .font(.title3)
                    .textSelection(.enabled)
                
                    .multilineTextAlignment(.leading)
                
                Spacer(minLength: 80)
                
                NavigationLink{
                    Welcome3(p: p)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)

                        Text("What Can I Do?")
                            .foregroundColor(Color("WB"))
                            .padding(.all)
                            .font(.title2)
                            
                    }
                }
            }
            .padding(.all)
            .navigationBarBackButtonHidden(true)
        }.background(
            Image("HomeLvl2")
                .resizable()
                .ignoresSafeArea()
            
                .padding(-20)
        )
    }
}

// Welcome screen 3
struct Welcome3: View {
    @State private var askHealth = false
    @State private var askNotif = false
    @State private var outAnim = false
    @AppStorage("welcomeScreenShown") var welcomeScreenShown: Bool = false
    @ObservedObject var p :  UserProgress
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                Spacer(minLength: 20)
                if !askNotif {
                    
                    Text(.init("**Start from little things.**\n\nFrom daily walks to travel abroad, this app provides practical recommendations for actions that can reduce greenhouse gas (GHG) emissions. \n\nIn order to recording the actions for you to remember, the actions are completed once you snap a picture of what you did. (your data is safe because this app is completely offline) \n\nYou will get points automatically once you complete an action. The points you earned will facilitate the growth of the tree. 100 points will be a level. If you get to level 6, you will see a fully grown tree with lots of fruits, which also affirms your effort. Isn’t that amazing?\n\nHowever, the points will be automatically cleared every 30 days. Don’t worry! You can still get them back by doing more actions."))
                        .padding(.all)
                        .font(.title3)
                        .scaleEffect(outAnim ? 0: 1, anchor: .top)
                    
                    HStack {
                        Spacer()
                        
                        //dismiss first text paragraph
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                outAnim = true
                                
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                askNotif = true
                            }
                        } label: {
                            Image(systemName: "arrow.right.circle")
                                .font(.largeTitle)
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                }
                
                // Ask for notification permission
                if askNotif {
                    Text(.init("First, we need your permission to send notifications for reminding you to act. There will only be three notifications everyday, at 9:30am, 12:30pm, and 6pm.\n\n**Simply click allow.**\n\n*However, it is totally fine if you don't want to recieve any notifications.*"))
                        .padding(.all)
                        .font(.title3)
                    
                    
                    HStack {
                        Spacer()
                        
                        // Request Authorization
                        Button {
                            NotificationManager.instance.requestAuth()
                            
                            // Make next one appear
                            askHealth = true
                        } label: {
                                Image(systemName: "checkmark.circle")
                                    .font(.largeTitle)
                            }.padding(.all)
                            
                    }.disabled(askHealth)
                }
                
                // Ask for healthkit permission
                if askHealth {
                    Text("Also, as mentioned, you can get points from walking instead of driving. To know how many steps you walked, we need to access your health data.\n\nAgain, this app is offline and your data is totally confidential.")
                        .padding(.all)
                        .font(.title3)
                    
                    
                    HStack {
                        Spacer()
                        
                        // A Button that initializes the app
                        // Presets 3 notifications, 1 point, and set welcomeScreenShown to true
                        // ContentView automatically refreshes to main page
                        Button {
                            NotificationManager.instance.cancelNotif()
                            NotificationManager.instance.scheduleNotification(title: "Morning", name: p.username, hour: 9, min: 30)
                            NotificationManager.instance.scheduleNotification(title: "Afternoon", name: p.username, hour: 12, min: 30)
                            NotificationManager.instance.scheduleNotification(title: "Evening", name: p.username, hour: 18, min: 00)
                            
                            p.set(a: 1)
                            welcomeScreenShown = true
                        } label: {
                                Image(systemName: "checkmark.circle")
                                    .font(.largeTitle)
                            }.padding(.all)
                            
                        }
                        
                        
                    }
                    
                    
                
                
                
                    
                
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        .background(Image("HomeLvl1")
            .resizable()
            .ignoresSafeArea()
        
            .padding(-20)
        )
            .navigationBarBackButtonHidden(true)
    }
        
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(p: UserProgress())
    }
}
