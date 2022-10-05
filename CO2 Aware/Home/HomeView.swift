//
//  HomeView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI


    
//    init(points: Int) {
//        self.points = points
//    }


struct HomeView: View {
   

    @ObservedObject var p :  UserProgress
    //@State var pLevel: Int = 0

    
    var body: some View {
        //let _ = Self._printChanges()
        NavigationStack{
            ScrollView(.vertical) {
                //Tree,clouds,and sun(moon) combination
                ZStack(alignment: .top){
                    
                    
                    Image("Cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack{
                        Image("Sun")
                            .resizable()
                            .frame(width: 90.0, height: 90.0)
                            
                            .overlay(
                                Text("Hi!")
                                    .font(.largeTitle.weight(.bold))
                                    //.padding(.leading)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    //.offset(x: 5, y: 5)
                            )
                        Spacer()
                        
                    }
                    
                    
                    Image("treeLvl" + String(p.level))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
          
                }
                
                
                .padding(.horizontal)
                Spacer(minLength: 15)
                RoundedRectangle(cornerRadius: 36)
                    .foregroundColor(Color("WB").opacity(0.5))
                    .padding(.horizontal)
                    .blur(radius: 0.3)
                    .frame(height: 160.0)
                    .overlay(
                        VStack{
                            ZStack(alignment: .topTrailing){
                                //Text("Level " + getCurrentLevel())
                                    //.font(.title2.weight(.semibold))
                                //Spacer()
                                ProgressView("Level " + String(p.level), value: Double(self.p.calculatedPoints), total: 100)
                                    .font(.title3.weight(.semibold))
                                Spacer()
                                Text(String(self.p.calculatedPoints) + "/100")
                                    //.frame(alignment: .top)
                                
                                
                                
                            }.padding(.horizontal)
                            HStack{
                                Text("Steps")
                                    .font(.title2.weight(.semibold))
                                Spacer()
                                
                            }.padding(.horizontal)
                            HStack{
                                Text("Actions")
                                    .font(.title2.weight(.semibold))
                                Spacer()
                                
                            }.padding(.horizontal)
                            HStack{
                                Text("Saved")
                                    .font(.title2.weight(.semibold))
                                Spacer()
                                
                            }.padding(.horizontal)
                            
                            
                            
                            
                        }.padding(.horizontal).frame(height: 150.0)
                    
                    )
                
                
                
                
            }
            .navigationTitle("Home")
            .toolbar(.hidden)
            .background(
                Image("HomeLvl" + String(p.level))
                .resizable()
                .ignoresSafeArea()
            )
//        }.onChange(of: isPresented) { isPresented in
//            if isPresented {
//                // Do something when first presented.
//                pPoints = p.points
//            }
//            
        }.environmentObject(p)
            
        
        
    }
        
        
    
    func getCurrentLevel() -> String{
        let points = p.points
        var level = 1
        level += points/100
        if (level  <= 6){
            return String(level)
        } else{
            return "6"
        }
    }
    
    func getCurrentPoints() -> Int{
        let points = p.points
        return points % 100
    }
    
    
    
    
}
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(p: UserProgress())
            //.environmentObject(UserProgress())
    }
}
