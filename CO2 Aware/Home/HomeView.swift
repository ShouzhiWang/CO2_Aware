//
//  HomeView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @ObservedObject var p :  UserProgress
    @State private var presentAlrt: Bool = false
    @State private var presentAlrt2: Bool = false
    @Environment(\.scenePhase) var scenePhase
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<Actions>
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    

    var body: some View {
        //Home view
        //NavigationView{
        
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
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Image("treeLvl" + String(p.level))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 800, height: 900)
                    } else {
                        Image("treeLvl" + String(p.level))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
          
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
                            ProgressView("Level \(String(p.level))", value: Double(self.p.calculatedPoints), total: 100)
                                .font(.title3.weight(.semibold))
                            Spacer()
                            //Text: calculated points
                            Text(String(self.p.calculatedPoints) + "/100")
                                
                            
                            
                            
                        }.padding(.horizontal)
                        
                        
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            
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
                                        .disabled(p.userSteps < 6000 || p.redeemProgress)
                                        
                                        
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
                        }
                        


                        
                        
                        VStack{
                            ZStack(alignment: .topTrailing){
                                //Day progress bar + text indicating days passed in the 30 days cycle
                                ProgressView("Day \( String(Calendar.current.dateComponents([.day], from: p.startDate, to: Date()).day!))", value: Double(Calendar.current.dateComponents([.day], from: p.startDate, to: Date()).day!), total: 30)
                                    .font(.title3.weight(.semibold))
                                Spacer()
                                //Text: total days
                                Text("/30")
                                
                            }.padding(.horizontal)
                        }
                        
                        Text("\(p.actionsCompleted) Actions compeleted since \(p.firstDay.formatted(date: .abbreviated, time: .omitted))")

                    }.padding(.all)
                    
                    
                }
                
                if !history.isEmpty {
                    let tempInstance = history.randomElement()!
                    ZStack{
                        RoundedRectangle(cornerRadius: 36)
                            .foregroundColor(Color("WB").opacity(0.2))
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 36))
                            .padding(.horizontal)
                            .blur(radius: 0.3)
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Do you remember?")
                                        .font(.title3.weight(.semibold))
                                    Text((tempInstance.date?.formatted(date: .abbreviated, time: .standard))!)
                                }
                                    
                                    
                                
                                Spacer()
                                NavigationLink{
                                    PastActionDetail(instance: tempInstance)
                                } label: {
                                    Image(systemName: "arrow.right")
                                }
                            }.padding(.horizontal)
                            if loadImageFromDocumentDirectory(instance: tempInstance) != nil {
                                Image(uiImage: loadImageFromDocumentDirectory(instance: tempInstance)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                            }
                        }.padding(.all)
                    }
                    
                    
                    
                    
                }
            }
                
            
            .navigationTitle("Home")
            .navigationBarHidden(true)
            
            
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
                Text("If you want to see your steps presented in CO2 Aware and earn steps points, please allow us to load your step data from Apple Health.\n\nYou can grant permission in Settings->Privacy->Health->CO2 Aware.\n\nIf you did not walk today or just woke up, please disregard this message! Your steps will be present after you have your step data.\n\nThank you!")
                    
            }
                    
            )
            
            .alert("It's been a month!", isPresented: $presentAlrt2, actions: {
                
            }, message:{
                VStack {
                    Image(systemName: "sun.max.fill")
                        .font(.largeTitle)
                    Text("A month or more just passed, so your points have been cleared. Let's start your earning for the next exciting 30 days!")
                }
            }
                    
            )
      
        //}
        .environmentObject(p)
            .onAppear{
                p.manageSteps()
                p.isDayChanged()
                    
                
                if p.daysBetween() {
                    presentAlrt2 = true
                }
                
                NotificationManager.instance.requestAuth()
                UIApplication.shared.applicationIconBadgeNumber = 0
                    
                
                
            }
            .onChange(of: scenePhase) {newValue in
                if newValue == .active{
                    p.manageSteps()
                    p.isDayChanged()
                }
                
            
                
                           
            }
     
    }
    func loadImageFromDocumentDirectory(instance: Actions) -> UIImage? {
            
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent("\(instance.imgName ?? "").jpg")
        
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                
                return nil
            }
    }
}
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(p: UserProgress())
           
    }
}
