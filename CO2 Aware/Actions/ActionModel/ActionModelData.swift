//
//  ActionModelData.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/25/22.
//


//  Source: https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit

import Foundation

class ActionModelData: ObservableObject {
    @Published var actionList: [Action] = loadAction("Actions.json")
    
    // Seperate action by their type
    var daily: [Action] {
        actionList.filter {$0.type == "Daily"}
    }
    
    var lifestyle: [Action] {
        actionList.filter {$0.type == "Lifestyle"}
    }
    
    var food: [Action] {
        actionList.filter {$0.type == "Food"}
    }
    
    var sw: [Action] {
        actionList.filter {$0.type == "School/Work"}
    }
    
    var travel: [Action] {
        actionList.filter {$0.type == "Travel"}
    }
    
    
}


// Load actions from json data and create action types
func loadAction<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


