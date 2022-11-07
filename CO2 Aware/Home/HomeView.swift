//
//  HomeView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var p :  UserProgress
    @State private var presentAlrt: Bool = false
    @Environment(\.scenePhase) var scenePhase
    

    var body: some View {
        //Home view
        NavigationStack{
            ScrollView(.vertical) {
                
                ZStack(alignment: .top){
                    
                    //Cloud Image
                    Image("Cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //Sun Image
                    HStack{
                        Image("Sun")
                            .resizable()
                            .frame(width: 90.0, height: 90.0)
                            //"HI" text
                            .overlay(
                                Text("Hi!")
                                    .font(.largeTitle.weight(.bold))
                                    .frame(maxWidth: .infinity, alignment: .center)
                            )
                        Spacer()
                    }
                    
                    //Changing tree image according to the level
                    Image("treeLvl" + String(p.level))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
          
                }
                
                
                .padding(.horizontal)
                Spacer(minLength: 15)
                
                //Rectangular region that shows the user's status
                
                ZStack{
                    RoundedRectangle(cornerRadius: 36)
                        .foregroundColor(Color("WB").opacity(0.2))
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 36))
                        .padding(.horizontal)
                        .blur(radius: 0.3)
                  
                    VStack{
                        ZStack(alignment: .topTrailing){
                            //Level progress bar + text indicating the level
                            ProgressView("Level " + String(p.level), value: Double(self.p.calculatedPoints), total: 100)
                                .font(.title3.weight(.semibold))
                            Spacer()
                            //Text: calculated points
                            Text(String(self.p.calculatedPoints) + "/100")
                                
                            
                            
                            
                        }.padding(.horizontal)
                        
                        ZStack(alignment: .topTrailing){
                            //Steps progress bar + text indicating the steps
                            
                            ProgressView("Steps", value: p.userSteps, total: 6000)
                                .font(.title3.weight(.semibold))
                            
                            Spacer()
                            HStack{
                                if p.userSteps != 0.0 {
                                    Button(){
                                        p.redeemProgress = true
                                        p.pointUp(point: 10)
                                    } label:{
                                        if p.redeemProgress {
                                            Text("Redeemed")
                                        } else {
                                            Text("Redeem")
                                        }
                                        
                                    }
                                        .disabled(p.userSteps < 1000 || p.redeemProgress)

                     
                                } else{
                                    Button(){
                                        presentAlrt = true
                                    } label: {
                                        Image(systemName: "questionmark.circle")
                                    }
                                    
                                }
                                
                                
                                //Text: calculated steps
                                Text(String(Int(p.userSteps)) + "/6000")
                            }
                
                        }.padding(.horizontal)
                        

                        HStack{
                            //Text: Actions
                            Text("Actions")
                                .font(.title2.weight(.semibold))
                            Spacer()
                            
                        }.padding(.horizontal)
                        HStack{
                            //Text: Emission Saved
                            Text("Saved")
                                .font(.title2.weight(.semibold))
                            Spacer()
                            
                        }.padding(.horizontal)

                    }.padding(.all)
                }
            }
            
            .navigationTitle("Home")
            .toolbar(.hidden)
            
            
            //Background Image that changes according to the level
            .background(
                Image("HomeLvl" + String(p.level))
               
                .resizable()
                .ignoresSafeArea()
                
                .padding(.horizontal, -20)
                .padding(.top, -50)
                .padding(.bottom, -100)
                //Trick: To escape from white patch @top & @bottom
            )
            .alert("No Steps?", isPresented: $presentAlrt, actions: {
                
            }, message:{
                Text("If you want to see your steps presented in CO2 Aware and earn steps points, please allow us to load your step data from Apple Health.\n\nYou can grant permission in Settings->Privacy->Health->CO2 Aware.\n\nIf you did not walk today or just woke up, please disregard this message! Your steps will present after you have your step data.\n\nThank you!")
                    
            }
                    
            )
      
        }.environmentObject(p)
            .onAppear{
                p.manageSteps()
                p.isDayChanged()
                
                
                
            }
            .onChange(of: scenePhase) {newValue in
                if newValue == .active{
                    p.manageSteps()
                    p.isDayChanged()
                }
                
                           
            }
     
    }
       
}
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(p: UserProgress())
           
    }
}
