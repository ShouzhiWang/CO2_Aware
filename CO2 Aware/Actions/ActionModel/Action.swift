//
//  Action.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/25/22.
//

import Foundation
import SwiftUI

// Define action type
struct Action: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var type: String
    var description: String
    var source: String
    var special: Bool
    var points: Int
    
    

    private var picture: String
    var image: Image? {
        if !picture.isEmpty {
            return Image(picture)
        } else {
            return nil
        }
    }
}

