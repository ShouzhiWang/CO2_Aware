/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/
//  Source: https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit


import Foundation
import SwiftUI


struct Article: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var date: String
    var author: String
    var content: String
    var link: String
    var isFeatured: Bool
    
    

    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var featureImage: Image? {
            isFeatured ? Image(imageName) : nil
        }
    
}
