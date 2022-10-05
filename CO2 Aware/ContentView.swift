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
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    @State private var selection = 0
    @StateObject var p =  UserProgress()
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
            
            
            
            //            List {
            //                ForEach(items) { item in
            //                    NavigationLink {
            //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            //                    } label: {
            //                        Text(item.timestamp!, formatter: itemFormatter)
            //                    }
            //                }
            //                .onDelete(perform: deleteItems)
            //            }
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    EditButton()
            //                }
            //                ToolbarItem {
            //                    Button(action: addItem) {
            //                        Label("Add Item", systemImage: "plus")
            //                    }
            //                }
            //            }
            //            Text("Select an item")
            //        }
            //    }
            //
            //    private func addItem() {
            //        withAnimation {
            //            let newItem = Item(context: viewContext)
            //            newItem.timestamp = Date()
            //
            //            do {
            //                try viewContext.save()
            //            } catch {
            //                // Replace this implementation with code to handle the error appropriately.
            //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //                let nsError = error as NSError
            //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            //            }
            //        }
            //    }
            //
            //    private func deleteItems(offsets: IndexSet) {
            //        withAnimation {
            //            offsets.map { items[$0] }.forEach(viewContext.delete)
            //
            //            do {
            //                try viewContext.save()
            //            } catch {
            //                // Replace this implementation with code to handle the error appropriately.
            //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //                let nsError = error as NSError
            //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            //            }
            //        }
            //    }
            //}
            //
            //private let itemFormatter: DateFormatter = {
            //    let formatter = DateFormatter()
            //    formatter.dateStyle = .short
            //    formatter.timeStyle = .medium
            //    return formatter
            //}()
        }
        
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(UserProgress())
                //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

