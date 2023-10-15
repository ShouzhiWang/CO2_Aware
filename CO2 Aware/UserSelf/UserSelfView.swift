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
                    }.frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                }
                
                    
                

                
                VStack{
                    
                    
                    if levelsm.envImpact == 0 {
                        Group{
                            NavigationLink{
                                TakingTest(p: levelsm)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("\(Image(systemName: "smoke")) What is your impact?")
                                        .padding([.top, .leading, .trailing])
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.title2.weight(.bold))
                                        .foregroundColor(Color("BW"))
                                    
                                    
                                    
                                    
                                    
                                    
                                    Text("Get a test now, through our newly introduced carbon footprint calculator. ")
                                        .multilineTextAlignment(.leading)
                                    
                                        .padding([.leading, .bottom, .trailing])
                                        .foregroundColor(Color("BW"))
                                    
                                    
                                }
                                
                            }.background(Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.red.opacity(0.7), .orange.opacity(0.8), .yellow.opacity(0.9), .green, .blue.opacity(0.8)]), startPoint: .trailing, endPoint: .zero)).cornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0))
                            
                            
                            Divider()
                        }
                        
                    } else {
                        Group{
                            NavigationLink{
                                TakingTest(p: levelsm)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("\(Image(systemName: "smoke")) My environmental impact")
                                        .padding([.top, .leading, .trailing])
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.title2.weight(.bold))
                                        .foregroundColor(Color("BW"))
                                    
                                    Group {
                                        switch levelsm.envImpact {
                                        case 1:
                                            HStack(alignment: .bottom){
                                                Text("😄")
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 50.0)
                                                    .padding(.vertical, 10.0)
                                                    .font(.largeTitle)
                                                    .background(RoundedRectangle(cornerRadius: 15).fill(.green))
                                                HStack{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.blue.opacity(0.5))
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.yellow.opacity(0.5))
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.red.opacity(0.5))
                                                }
                                                .frame(maxHeight: 40)
                                            }
                                            
                                        case 2:
                                            HStack(alignment: .bottom){
                                                
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(.green.opacity(0.5))
                                                    .frame(maxHeight: 40)
                                                Text("😊")
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 25.0)
                                                    .padding(.vertical, 10.0)
                                                    .font(.largeTitle)
                                                    .background(RoundedRectangle(cornerRadius: 15).fill(.blue))
                                                
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.yellow.opacity(0.5))
                                                        .frame(maxHeight: 40)
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.red.opacity(0.5))
                                                
                                                .frame(maxHeight: 40)
                                            }
                                            
                                        case 3:
                                            HStack(alignment: .bottom){
                                                
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(.green.opacity(0.5))
                                                    .frame(maxHeight: 40)
                                                
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(.blue.opacity(0.5))
                                                    .frame(maxHeight: 40)
                                                
                                                Text("🧐")
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 25.0)
                                                    .padding(.vertical, 10.0)
                                                    .font(.largeTitle)
                                                    .background(RoundedRectangle(cornerRadius: 15).fill(.orange))
                                                
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(.red.opacity(0.5))
                                                    .frame(maxHeight: 40)
                                            }
                                            
                                        case 4:
                                            HStack(alignment: .bottom){
                                                HStack{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.green.opacity(0.5))
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.blue.opacity(0.5))
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(.yellow.opacity(0.5))
                                                }
                                                .frame(maxHeight: 40)
                                                Text("🥺")
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 50.0)
                                                    .padding(.vertical, 10.0)
                                                    .font(.largeTitle)
                                                    .background(RoundedRectangle(cornerRadius: 15).fill(.red))
                                                
                                            }
                                            
                                            
                                            
                                        default:
                                            RoundedRectangle(cornerRadius: 20)
                                        }
                                    }
                                        .padding(.horizontal)
                                    
                                    
                                    
                                    switch levelsm.envImpact {
                                    
                                        
                                    case 1:
                                        Text("Right now, you are making a small impact on our planet. Keep going!")
                                            .multilineTextAlignment(.leading)
                                            .padding([.leading, .bottom, .trailing])
                                            .foregroundColor(Color("BW"))
                                        
                                    case 2:
                                        Text("Right now, your lifestyle is environmental friendly. Keep going!")
                                            .multilineTextAlignment(.leading)
                                            .padding([.leading, .bottom, .trailing])
                                            .foregroundColor(Color("BW"))
                                        
                                    case 3:
                                        Text("Ummm... Your environmental impact is somewhat high. Consider about doing some actions or viewing articles!")
                                            .multilineTextAlignment(.leading)
                                            .padding([.leading, .bottom, .trailing])
                                            .foregroundColor(Color("BW"))
                                        
                                    case 4:
                                        Text("Not good! Your lifestyle is causing a significant negative impact. Consider about doing some actions or viewing articles!")
                                            .multilineTextAlignment(.leading)
                                            .padding([.leading, .bottom, .trailing])
                                            .foregroundColor(Color("BW"))
                                        
                                        
                                        
                                    default:
                                        Text("Get a test now, through our newly introduced carbon footprint calculator. ")
                                            .multilineTextAlignment(.leading)
                                        
                                            .padding([.leading, .bottom, .trailing])
                                            .foregroundColor(Color("BW"))
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                                
                            }
                            
                            
                            Divider()
                        }
                    }
                    
                    
                    Group{
                        Text("\(Image(systemName: "bell")) Notification")
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2.weight(.bold))
                    
                    
                        
                        Text("To turn it ON/OFF, go to Settings, Notifications, find 'CO2 Aware', and turn its notification ON/OFF.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        
                        Divider()
                    }
                    
                    Group {
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
                    }
                    
                    
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
                }.frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                
                
                
                
                
             
                
                
            }.sheet(isPresented: $showPopover) {
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
            
 
            
            .sheet(isPresented: $showPopover2) {
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
                    .padding(.all)
                  
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .showTabBar(animated: true)
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
