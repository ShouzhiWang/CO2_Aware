//
//  ContentView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/16/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selection = 0
    @StateObject var p =  UserProgress()
    @State private var presentAlrt: Bool = false
    @StateObject var md = ModelData()
    @StateObject var amd = ActionModelData()

    @AppStorage("welcomeScreenShown") var welcomeScreenShown: Bool = false
    
    
    var body: some View {
        NavigationView {
            if welcomeScreenShown{
                TabView(selection: $selection){
                    HomeView(p: p)
                        .tabItem {
                            Label("Home", systemImage: "leaf")
                        }
                        .tag(0)
                        //.navigationTitle("Home")
                        .navigationBarHidden(true)
                    
                    ActionsView(p: p).environmentObject(amd)
                        .tabItem {
                            Label("Actions", systemImage: "checkmark.seal")
                        }
                        .tag(1)
                    
                    DiscoverView().environmentObject(md)
                        .tabItem {
                            Label("Discover", systemImage: "newspaper")
                        }
                        .tag(2)
                    
                    UserSelfView(levelsm: p)
                        .tabItem {
                            Label("About Me", systemImage: "person")
                        }
                        .tag(3)
                    
                }
                
            } else {
                WelcomeView(p: p)
            }
        }.navigationViewStyle(.stack)
        
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(UserProgress())
                .environmentObject(ModelData())
                .environmentObject(ActionModelData())
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
              
        }
    }
}

