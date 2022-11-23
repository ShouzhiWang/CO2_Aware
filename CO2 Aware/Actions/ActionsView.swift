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
    //@Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<Actions>
    
    @State private var title: String = ""
    @State private var reference: String = ""
    @State private var imgName: String = ""
    
    var body: some View {
        NavigationView{
            
            
            List{
                Section {
                    TextField("Title", text: $title)
                    TextField("Ref", text: $reference)
                    TextField("Img", text: $imgName)
                    Button("Save"){
                        addInstance(imgName: imgName, reference: reference, title: title, context: managedObjContext)
                        
                    }
                }
                
                Section{
                   ForEach(history) { instance in
                            Text(instance.title!)
                        }
                    
                }
            }
            
            .navigationTitle("Actions")
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            
        } catch {
            print("FAILED to save the data")
        }
        
    }
    
    func addInstance(imgName: String, reference: String, title: String, context: NSManagedObjectContext){
        let instance = Actions(context: context)
        instance.id = UUID()
        instance.date = Date()
        instance.title = title
        instance.reference = reference
        instance.imgName = imgName
        
        save(context: context)
    }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
