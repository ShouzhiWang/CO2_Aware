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

    
    
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection){
                HomeView(p: p)
                    .tabItem {
                        Label("Home", systemImage: "leaf")
                    }
                    .tag(0)
                
                ActionsView()
                    .tabItem {
                        Label("Actions", systemImage: "checkmark.seal")
                    }
                    .tag(1)
                
                DiscoverView()
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
        }
        .onAppear{
            if p.daysBetween() {
                presentAlrt = true
            }
        
        }
        .alert("Yah! It's been a month.", isPresented: $presentAlrt, actions: {
            
        }, message:{
            VStack {
                Image(systemName: "sun.max.fill")
                    .font(.largeTitle)
                Text("A month or more just passed, so your points have been cleared. Let's start your earning for the next exciting 30 days!")
            }
        }
                
        )
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(UserProgress())
              
        }
    }
}

