//
//  UserSelfView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI


struct UserSelfView: View {
    @ObservedObject var levelsm : UserProgress
    @State private var tempname: String = ""

    @State private var showPopover: Bool = false
    @State private var showPopover2: Bool = false
    @State private var isNotif: Bool = false
    
    var worldData = loadCSV()
    @State private var tempCo2: GHG?

    @AppStorage("welcomeScreenShown") var welcomeScreenShown: Bool = true
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    Image("Earth")
                        .resizable()
                      
                        .frame(height: 330)
                    VStack {
                        Spacer()
                        HStack{
                            
                            VStack{
                                Text("Welcome,")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                                
                                    
                                if (levelsm.username == ""){
                                    Text("Tap arrow to edit")
                                        .foregroundColor(Color.white)
                                } else {
                                    Text(levelsm.username)
                                        .font(.title.weight(.bold))
                                        
                                        .foregroundColor(Color.white)
                                }
                            }.padding(.leading)
                            Spacer()
                            Text("Your Level: \n" + String(levelsm.level) + "/6")
                                .foregroundColor(Color.white)
                                .padding(.trailing)
                            Image(systemName: "arrow.up.forward")
                                .foregroundColor(Color("AccentColor"))
                                .padding(.trailing)
                                .onTapGesture {
                                    showPopover = true
                                }
                        }
                        Spacer()
                        ZStack{
                            
                            VStack{
                                Text("Per capita GHG emission")
                                    .foregroundColor(Color.white)
                                
                                HStack{
                                    Text(String(levelsm.co2e))
                                        .font(.title.weight(.bold))
                                        
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
                            
                            HStack{
                                Spacer()
                                Image(systemName: "arrow.up.forward")
                                    .foregroundColor(Color("AccentColor"))
                                    .padding(.trailing)
                                    
                                    .onTapGesture {
                                        showPopover2 = true
                                    }
                            }
                            
                            
                            
                            
                        }.padding(.bottom)
                    }
                }
                
                    
                

                Spacer()
                
                

                
                Spacer()
                
                VStack{
                    
                    Text("\(Image(systemName: "bell")) Notification")
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2.weight(.bold))
                            
                            
                    Text("To turn it ON/OFF, go to Settings, Notifications, find 'CO2 Aware', and turn its notification ON/OFF.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                        
                    Divider()
                    
                    Button("\(Image(systemName: "doc.richtext")) Show welcome screen again"){
                        welcomeScreenShown = false
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .font(.title2.weight(.bold))
                    
                    
                    Text("Note: Doing so will reset your points earned for this month")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .foregroundColor(.red)
                    
                    Divider()
                    
                    NavigationLink {
                        About_US()
                    } label: {
                        Text("\(Image(systemName: "person.2.fill")) About us")
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .font(.title2.weight(.bold))
                        
                    Divider()
                    
                    Text("\(Image(systemName: "ellipsis.circle")) More Coming!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .font(.title2)
                        
                    
                    
                    Divider()
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
                                .font(Font.body.bold())
                            
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
            .ignoresSafeArea()

        }
    }
        
    
    func saveName() {
        levelsm.username = tempname
        NotificationManager.instance.cancelNotif()
        NotificationManager.instance.scheduleNotification(title: "Morning", name: levelsm.username, hour: 9, min: 30)
        NotificationManager.instance.scheduleNotification(title: "Afternoon", name: levelsm.username, hour: 12, min: 30)
        NotificationManager.instance.scheduleNotification(title: "Evening", name: levelsm.username, hour: 18, min: 00)

        
    }
    
    struct UserSelfView_Previews: PreviewProvider {
        static var previews: some View {
            UserSelfView(levelsm: UserProgress())
        }
    }
}
