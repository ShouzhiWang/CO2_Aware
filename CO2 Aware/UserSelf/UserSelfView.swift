//
//  UserSelfView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI
//import CoreData

struct UserSelfView: View {
    @AppStorage("username") var username: String = ""
    @AppStorage("points") var points: Int = 0
    @State private var tempname: String = ""
    @State private var temppoints: String = ""
    
    var body: some View {
        
        if (username == "") {
            VStack{
                TextField("Nickname", text: $tempname)
                TextField("Points", text: $temppoints)
                    .keyboardType(.decimalPad)
                
                Button("save") {
                    saveName()
                    
                }
                
                
                
            }
            
            
            
        } else{
            VStack {
                
                Text(username)
                Text(String(UserDefaults.standard.integer(forKey: "points")))
                Button("Clear") {
                    UserDefaults.standard.set(nil, forKey: "username")

                }
                
            }
        }
        
    }
    
    func saveName() {
        username = tempname
        UserProgress().set(a: Int(temppoints) ?? 0)
        //UserDefaults.standard.set(Int(temppoints), forKey: "points")
    }
    
    struct UserSelfView_Previews: PreviewProvider {
        static var previews: some View {
            UserSelfView()
        }
    }
}
