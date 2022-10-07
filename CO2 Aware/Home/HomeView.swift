//
//  HomeView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var p :  UserProgress

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
                RoundedRectangle(cornerRadius: 36)
                    .foregroundColor(Color("WB").opacity(0.2))
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 36))
                    .padding(.horizontal)
                    .blur(radius: 0.3)
                    .frame(height: 160.0)
                    .overlay(
                        VStack{
                            ZStack(alignment: .topTrailing){
                                //Level progress bar + text indicating the level
                                ProgressView("Level " + String(p.level), value: Double(self.p.calculatedPoints), total: 100)
                                    .font(.title3.weight(.semibold))
                                Spacer()
                                //Text: calculated points
                                Text(String(self.p.calculatedPoints) + "/100")
                                    
                                
                                
                                
                            }.padding(.horizontal)
                            HStack{
                                //Text: Steps
                                Text("Steps")
                                    .font(.title2.weight(.semibold))
                                Spacer()
                                
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

                        }.padding(.horizontal).frame(height: 150.0)
                    
                    )
                
                
                
                
            }
            .navigationTitle("Home")
            .toolbar(.hidden)
            //Background Image that changes according to the level
            .background(
                Image("HomeLvl" + String(p.level))
                .resizable()
                .ignoresSafeArea()
                .padding(-20) //Trick: To escape from white patch @top & @bottom
            )
      
        }.environmentObject(p)
     
    }
       
}
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(p: UserProgress())
           
    }
}
