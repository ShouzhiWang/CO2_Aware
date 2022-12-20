//
//  ImagePicker.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/24/22.
//

import UIKit
import SwiftUI
import CoreData

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<Actions>
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    @Binding var imgName: String
    @Binding var action: Action
    @ObservedObject var p :  UserProgress
    
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                saveJpg(image, name: parent.imgName)
            }
            
            parent.addInstance(imgName: parent.imgName, reference: parent.action.description, title: parent.action.title, context: parent.managedObjContext, points: String(parent.action.points))
            parent.p.pointUp(point: parent.action.points)
            parent.presentationMode.wrappedValue.dismiss()
            
        }
        
        func documentDirectoryPath() -> URL? {
            let path = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)
            return path.first
        }
        
        func saveJpg(_ image: UIImage, name: String) {
            if let jpgData = image.jpegData(compressionQuality: 0.2),
                let path = documentDirectoryPath()?.appendingPathComponent("\(name).jpg") {
                try? jpgData.write(to: path)
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            
        } catch {
            print("FAILED to save the data")
        }
        
    }
    
    func addInstance(imgName: String, reference: String, title: String, context: NSManagedObjectContext, points: String){
        let instance = Actions(context: context)
        instance.id = UUID()
        instance.date = Date()
        instance.title = title
        instance.reference = reference
        instance.imgName = imgName
        instance.points = points
        
        p.newAction()
        save(context: context)
    }
}


