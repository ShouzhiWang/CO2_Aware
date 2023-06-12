//
//  ActionsView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI
import CoreData
import HidableTabView

struct ActionsView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<Actions>
    @EnvironmentObject var actionModel: ActionModelData
    
    @State private var title: String = ""
    @State private var reference: String = ""
    
    @ObservedObject var p:  UserProgress
    @State private var popUp: Bool = false
    
    
    
    var body: some View {
        NavigationView{
                List{
                    
                        if p.envImpact == 0 {
                            Section {
                                NavigationLink{
                                    TakingTest(p: p)
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
                                    
                                }.background(Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.red.opacity(0.7), .orange.opacity(0.8), .yellow.opacity(0.9), .green, .blue.opacity(0.8)]), startPoint: .trailing, endPoint: .zero)))
                                    .listRowInsets(EdgeInsets())
                                
                                
                                
                            
                            
                        }
                                                    
                    }
                    
                    
                    
                    // Daily actions section
                    Section{
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(actionModel.daily) { action in
                                    VStack{
                                        NavigationLink{
                                            ActionDetail(action: action, p: p)
                                        } label: {
                                            action.image!
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 180, height: 180, alignment: .center)
                                                .clipped()
                                                .cornerRadius(20)
                                        }.padding(.top, 5.0)
                                        Text(action.title)
                                            .font(.caption)
                                            .padding(.bottom, 3.0)
                                        
                                    }
                                }
                            }.padding(.horizontal)
                        }.listRowInsets(EdgeInsets())
                    } header: {
                        Text("Daily")
                    }
                    
                    
                    
                    
                    // Lifestyle related actions
                    Section{
                        DisclosureGroup {
                            ForEach(actionModel.lifestyle) { action in
                                NavigationLink {
                                    ActionDetail(action: action, p: p)
                                } label: {
                                    Text(action.title)
                                }
                            }
                        } label: {
                            HStack{
                                
                                (Text(Image(systemName: "sun.haze")) + Text("  Lifestyle"))
                                    .font(.title2)
                                    .bold()
                            }
                            
                        }
                        
                        
                        // School, Work related
                        DisclosureGroup {
                            ForEach(actionModel.sw) { action in
                                NavigationLink {
                                    ActionDetail(action: action, p: p)
                                } label: {
                                    Text(action.title)
                                }
                            }
                        } label: {
                            HStack{
                                (Text(Image(systemName: "pencil.and.outline")) + Text("  School & Work"))
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            
                        }
                        
                        
                        // Food related
                        DisclosureGroup {
                            ForEach(actionModel.food) { action in
                                NavigationLink {
                                    ActionDetail(action: action, p: p)
                                } label: {
                                    Text(action.title)
                                }
                            }
                        } label: {
                            HStack{
                                (Text(Image(systemName: "fork.knife")) + Text("   Food"))
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            
                        }
                        
                        DisclosureGroup {
                            ForEach(actionModel.travel) { action in
                                NavigationLink {
                                    ActionDetail(action: action, p: p)
                                } label: {
                                    Text(action.title)
                                }
                            }
                        } label: {
                            HStack{
                                (Text(Image(systemName: "airplane")) + Text(" Travel"))
                                    .font(.title2)
                                    .bold()
                            }
                            
                        }
                        

                    } header: {
                        Text("Others")
                    }
                    
                    
                    
                    
              
                    
                }
                .listStyle(.insetGrouped)
            
            
            .navigationTitle("Actions")
            .showTabBar(animated: true)
            // History button
            .toolbar {
                Button() {
                    popUp.toggle()
                    
                    
                } label: {
                    Text("History")
                }
            }
            }
        
        
        // History (popup) Page
            .sheet(isPresented: $popUp) {
                NavigationView{
                    List{
                        Section{
                            ForEach(history.sorted(by: {$0.date! > $1.date!})) { instance in
                                NavigationLink {
                                    PastActionDetail(instance: instance)
                                } label: {
                                    Text(instance.title!)
                                }
                                
                            }.onDelete(perform: deleteItems)
                            
                        }
                    }
                    .toolbar{
                        Button("Done") {
                            popUp.toggle()
                        }
                    }
                    
                }
                
            }
        
    }
    
    // Delete history instance
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { history[$0] }.forEach(managedObjContext.delete)

            do {
                try managedObjContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        
        
    }
    
    
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView(p: UserProgress())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ActionModelData())
    }
}
