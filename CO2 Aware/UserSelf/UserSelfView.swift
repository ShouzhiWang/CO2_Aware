//
//  UserSelfView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI


struct UserSelfView: View {
    //@AppStorage("username") var username: String = ""
    
    @ObservedObject var levelsm : UserProgress
    @State private var tempname: String = ""
    @State private var temppoints: String = ""
    @State private var showPopover: Bool = false
    @State private var showPopover2: Bool = false
    var worldData = loadCSV()
    @State private var tempCo2e: Double = 0.00
    @State private var tempCo2Region = ""
    
    var settings: [String] = ["a", "b", "c", "d"]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                //User information
                HStack{
                    Spacer()
                    ZStack{
                        Button() {
                            showPopover = true
                        } label:{
                            Image("HomeLvl" + String(levelsm.level))
                                .resizable()
                                .padding(.all, -10.0)
                                .cornerRadius(35)
                                .blur(radius: 3)
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                        }
                        HStack{
                            
                            VStack{
                                Text("Welcome,")
                                    .font(.title2)
                                    
                                if (levelsm.username == ""){
                                    Text("Tap to edit")
                                } else {
                                    Text(levelsm.username)
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                            }.padding(.leading)
                            Spacer()
                            Text("Your Level: \n" + String(levelsm.level) + "/6")
                                .padding(.trailing)
                            Image(systemName: "arrow.up.forward")
                                .foregroundColor(Color("AccentColor"))
                                .padding(.trailing)
                        }
                    }
                    .frame(height: 130.0)
                    Spacer()
                }
                
                
                
                
                //Local CO2 eq emission avg
                HStack{
                    Spacer()
                    ZStack{
                        Button() {
                            showPopover2 = true
                        } label:{
                            Image("Earth")
                                .resizable()
                                .padding(.all, -10.0)
                                .cornerRadius(35)
                                .blur(radius: 3)
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                        }
                        HStack{
                            Spacer()
                            VStack{
                                Text("Per capita GHG emission")
                                    .foregroundColor(Color.white)
                                
                                HStack{
                                    Text(String(levelsm.co2e))
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    Text("CO2e")
                                        .font(.subheadline)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, -5.0)
                                        
                                }
                                Text("🌍 " + levelsm.co2Region)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                           
                        }
                    }
                    .frame(height: 130.0)
                    Spacer()
                }

                Spacer()
                
                
                //Setting
                
                Text("Settings")
                    .fontWeight(.bold)
                    .padding([.top, .leading])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Spacer()
                ForEach(settings, id: \.self){ setting in
                    VStack{
                        Text(setting)
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)
                        Divider()
                    }
                }
                
             
                
                
            }.popover(isPresented: $showPopover) {
                //Popover of changing name
                VStack{
                    HStack{
                        Button{
                            showPopover = false
                        } label: {
                            Text("Cancel")
                        }
                        Spacer()
                        Button{
                            if tempname.count <= 15 {
                                saveName()
                                showPopover = false
                            }
                        } label: {
                            Text("Save")
                                .font(.body)
                                .fontWeight(.bold)
                            
                        }
                    }.padding(.all)
                    Text("Edit your nickname")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack{
                        TextField("Nickname", text: $tempname)
                            .padding(.horizontal)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        if tempname.count <= 15 {
                            Text(String(tempname.count) + "/15")
                                .padding(.trailing)
                        } else {
                            Text(String(tempname.count) + "/15")
                                .padding(.trailing)
                                .foregroundColor(Color.red)
                        }
                        
                    }
                
                    
                    
                    Text("!TEMP!!!POINTS!")
                    TextField("Points", text: $temppoints)
                        .padding(.leading)
                            .keyboardType(.decimalPad)
                    
                    Spacer()
                        
                }
                
                
                
                
                
            }
            
            .popover(isPresented: $showPopover2) {
                VStack {
                    Picker("Select a region", selection: $tempCo2Region) {
                        ForEach(worldData, id: \.self) { v in
                            Text(v.country).tag(v.country)
                            
                        }
                    }
                    .pickerStyle(.menu)
                    Text(tempCo2Region)
                }
            }
            
            .navigationTitle("About Me")
            
            

        }
        }
        
    
    func saveName() {
        levelsm.username = tempname
        levelsm.points = Int(temppoints) ?? 0
        
    }
    
    struct UserSelfView_Previews: PreviewProvider {
        static var previews: some View {
            UserSelfView(levelsm: UserProgress())
        }
    }
}

//            if (username == "") {
//                VStack{
//                    TextField("Nickname", text: $tempname)
//                    TextField("Points", text: $temppoints)
//                        .keyboardType(.decimalPad)
//
//                    Button("save") {
//                        saveName()
//                    }
//                }
//            } else{
//                VStack {
//
//                    Text(username)
//                    Text(String(levelsm.points))
//                    Button("Clear") {
//                        UserDefaults.standard.set(nil, forKey: "username")
//
//                    }
//
//                }
//            }
