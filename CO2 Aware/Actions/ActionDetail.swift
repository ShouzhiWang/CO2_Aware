//
//  ActionDetail.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/26/22.
//

import SwiftUI
import CoreData
import HidableTabView

struct ActionDetail: View {
    @State var action: Action
    @State private var camUp: Bool = false
    @State private var imgName: String = ""
    @ObservedObject var p:  UserProgress
    @State private var ifDone: Bool = false
    @Environment(\.presentationMode) var presentation
    
    
    // Detail page of actions
    var body: some View {
        ScrollView{
            if action.image != nil{
                action.image!
                    .resizable()
                    .aspectRatio(3/2, contentMode: .fit)
                    .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                    .cornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0)
            }
            
                VStack(alignment: .leading) {
                    Text(action.title)
                        .font(.title.weight(.bold))
                        
                    
                    Text("\(String(action.points)) Points")
                        
                        .font(.title3.weight(.bold))
                    
                    Divider()
                    
                    Text(.init(action.description))
                       
                        
                    
                    Divider()
                    
                    
                }.padding(.horizontal)
                .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                Text("In order to complete,")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    if !action.special {
                        Button {
                            imgName = UUID().uuidString
                            camUp.toggle()
                            presentation.wrappedValue.dismiss()
                            
                        } label: {
                            (Text(Image(systemName: "camera.fill")) + Text(" Snap a photo"))
                                .padding(22)
                                .background(Color("AccentColor"))
                                .foregroundColor(Color("WB"))
                                .font(Font.body.bold())
                        }.frame(height: 50)
                         .background(Color("AccentColor")).cornerRadius(10)
                    } else if(UIDevice.current.userInterfaceIdiom == .pad){
                        Text("Sorry, this feature is only available on our app's iPhone version.")
                            .padding(.all)
                            .font(Font.body.bold())
                            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
                        
                    } else {
                        Text("Walk at least 6000 steps and go to home page to click 'Redeem' in 'Steps' section")
                            .padding(.all)
                            .font(Font.body.bold())
                    }
                    
                    Spacer()

                    
            Text("Source: \n[\(action.source)](\(action.source))")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.all)
                .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 500 : .infinity)
            
        }
  
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $camUp) {
            ImagePicker(imgName: $imgName, action: $action, p: p)
            .ignoresSafeArea()
            .navigationBarHidden(true)
            
        }
        .hideTabBar(animated: true)
    }
    
    
}

struct ActionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActionDetail(action: ActionModelData().daily[0], p: UserProgress())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
