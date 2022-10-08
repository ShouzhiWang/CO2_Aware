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
    @State private var tempCo2: GHG?
    
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
                                    Text("t CO2e")
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
                        
                            saveName()
                            showPopover = false
                            
                        } label: {
                            Text("Save")
                                .font(.body)
                                .fontWeight(.bold)
                            
                        }.disabled(tempname.count > 15 || tempname.count == 0)
                    }.padding(.all)
                    
                    Image(systemName: "paintbrush")
                        .foregroundColor(Color("AccentColor"))
                        .font(.largeTitle)
                        .padding(.all)
                    
                    
                    Text("Edit your nickname")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    HStack{
                        TextField("Nickname", text: $tempname)
                            .padding(.all)
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
                    HStack{
                        Button("Cancel") {
                            showPopover2 = false
                        }
                        Spacer()
                    }.padding(.all)
                    
                    Image(systemName: "globe")
                        .foregroundColor(Color("AccentColor"))
                    
                        .font(.system(size: 50))
                        .padding(.all)
                    
                    if levelsm.co2Region == "... Please Choose" {
                        Text("Select Your Region")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    } else{
                        Text("Edit Your Region")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    

//                    HStack{
//                        Text("Your Region:")
//                            .fontWeight(.bold)
//                        Spacer()
//                    }.padding([.top, .leading])
                    
                    HStack {
                        Picker("Select a region", selection: $tempCo2) {
                            ForEach(worldData, id: \.self) { v in
                                Text(v.country).tag(v as GHG?)
                            }
                        }.pickerStyle(.menu)
                        Spacer()
                    }.padding(.leading)
                    
                    
                    if tempCo2 != nil && tempCo2?.country != "...Please Select"{
                        HStack{
                            Text("CO₂e emission per capita (tons)")
                                .fontWeight(.bold)
                                .padding(.leading)
                                .font(.title3)
                            Spacer()
                        }.padding(.leading)
                        
                        HStack{
                            Text("\(tempCo2?.emission ?? "")")
                                .padding(.leading)
                                .font(.title)
                            
                            Spacer()
                                
                        }.padding(.leading)
                        
                       
                                
                        
                        
                    }
                    HStack{
                        Text("[Learn More](https://en.wikipedia.org/wiki/Greenhouse_gas_emissions)")
                            .padding(.leading)
                        Spacer()
                    }.padding(.leading)
                        //Spacer()
                    //.padding(.horizontal)
                    
                    
                    
                    Spacer()
                    Divider()
                    VStack{
                        HStack{
                            Image(systemName: "note.text")
                                .padding([.top, .leading, .trailing])
                                .foregroundColor(Color("Label"))
                            Spacer()
                        }
                        
                        
                        
                        Text("The data is from 2019.\nEmissions are measured in carbon dioxide equivalents (CO2eq). This means non-CO2 gases are weighted by the amount of warming they cause over a 100-year timescale. Emissions from land use change – which can be positive or negative – are taken into account.\n\nSource: Our World In Data, Per capita greenhouse gas emissions")
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .padding(.all)
                            .foregroundColor(Color("Label"))
                        
                    }
                    HStack {
                        Button(action: {
                            levelsm.co2Region = tempCo2?.country ?? "Undefined"
                            
                            levelsm.co2e = Double(tempCo2?.emission ?? "0.02") ?? 0.03
                            showPopover2 = false
                        }) {
                            Text("Save")
                                .font(.body)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .fontWeight(.bold)
                            
                                .padding()
                                .foregroundColor(Color("WB"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("WB"), lineWidth: 2)
                            )
                        }
                        .background(Color.accentColor)
                        .cornerRadius(15)
                        .disabled(tempCo2 == nil || tempCo2?.country == "...Please Select")

                    }
                    .padding(.horizontal)
                  
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
