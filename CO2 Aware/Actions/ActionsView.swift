//
//  ActionsView.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/17/22.
//

import SwiftUI
import CoreData

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
                        
//                        DisclosureGroup {
//
//                            TextField("Title", text: $title)
//                            TextField("Ref", text: $reference)
//                            TextField("Img", text: $imgName)
//                            Button("Save"){
//                                addInstance(imgName: imgName, reference: reference, title: title, context: managedObjContext)
//
//                            }
//                        } label: {
//                            Text("Settings")
//                        }
                    } header: {
                        Text("Others")
                    }
                    
                    
                    
                    
              
                    
                }
                .listStyle(.inset)
            
            
            .navigationTitle("Actions")
            .toolbar {
                Button() {
                    popUp.toggle()
                    //imgName = UUID().uuidString
                    
                    
                } label: {
                    Text("History")
                }
            }
            }
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
