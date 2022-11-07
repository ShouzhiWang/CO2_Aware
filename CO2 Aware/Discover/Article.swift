/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation

struct Article: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var date: String
    var author: String
    var content: String
    var isFeatured: Bool

    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    
}
