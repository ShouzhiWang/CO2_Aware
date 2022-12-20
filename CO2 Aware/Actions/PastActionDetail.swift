//
//  PastActionDetail.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/24/22.
//

import SwiftUI
import UIKit

struct PastActionDetail: View {
    
    var instance: Actions
    

    var body: some View {
        VStack{
            if loadImageFromDocumentDirectory() != nil {
                Image(uiImage: loadImageFromDocumentDirectory()!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            HStack{
                VStack(alignment: .leading){
                    Text(instance.title ?? "Non")
                        .font(.largeTitle)
                        .bold()
                    
                    Text((instance.date ?? Date()).formatted(date: .abbreviated, time: .shortened))
                    
                    Text("\(instance.points ?? "Unknown") Points")
                        .padding(.top)
                        .font(.title2)
                        .bold()
                    
                    Text(.init(instance.reference ?? "No Description"))
                    
                
                    
                    
                }.padding(.leading)
                
                    
                Spacer()
            }
                
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func loadImageFromDocumentDirectory() -> UIImage? {
            
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent("\(instance.imgName ?? "").jpg")
        
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                
                return nil
            }
    }
}



struct PastActionDetail_Previews: PreviewProvider {
    
    static var viewContext = PersistenceController.preview.container.viewContext
    static var previews: some View {
        let action = Actions(context: viewContext)
        action.title = "Sample title"
        action.reference = "Sample description"
        action.imgName = ""
        action.points = "33"
        action.id = UUID()
        action.date = Date()
        
        
        return PastActionDetail(instance: action).environment(\.managedObjectContext, viewContext)
       
    }

}
