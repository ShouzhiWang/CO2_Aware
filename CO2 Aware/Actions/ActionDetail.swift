//
//  ActionDetail.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/26/22.
//

import SwiftUI
import CoreData

struct ActionDetail: View {
    @State var action: Action
    @State private var camUp: Bool = false
    @State private var imgName: String = ""
    @ObservedObject var p:  UserProgress
    @State private var ifDone: Bool = false
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView{
            if action.image != nil{
                action.image!
                    .resizable()
                    .aspectRatio(3/2, contentMode: .fit)
            }
            HStack{
                VStack(alignment: .leading) {
                    Text(action.title)
                        .font(.title)
                        .bold()
                    
                    Text("\(String(action.points)) Points")
                        .bold()
                        .font(.title3)
                    
                    Divider()
                    
                    Text(.init(action.description))
                        .font(.title3)
                    
                    Divider()
                    Text("In order to complete,")
                }.padding(.horizontal)
            }
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
                                .bold()
                        }.frame(height: 50)
                         .background(Color("AccentColor")).cornerRadius(10)
                    } else {
                        Text("Walk at least 6000 steps and go to home page to click 'Redeem' in 'Steps' section")
                            .padding(.all)
                            .bold()
                    }
                    
                    Spacer(minLength: 150)

                    
                
                
            
        }
        .overlay(
            Text("Source: \n[\(action.source)](\(action.source))")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.all)
            , alignment: .bottom)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $camUp) {
            ImagePicker(imgName: $imgName, action: $action, p: p)
            .ignoresSafeArea()
            .navigationBarHidden(true)
            
        }
        
    }
    
    
}

struct ActionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActionDetail(action: ActionModelData().daily[0], p: UserProgress())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
