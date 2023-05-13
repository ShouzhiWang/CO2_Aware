/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

//  Source: https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit

import Foundation

final class ModelData: ObservableObject {
    @Published var articles: [Article] = load("articles2.json")
    

    var features: [Article] {
        articles.filter {$0.isFeatured}
    }
    
    var others: [Article] {
        articles.filter {!$0.isFeatured}
    }

    
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    let locale = Locale.current
    if locale.languageCode == "zh" {
        guard let file = Bundle.main.url(forResource: "Articles_zh.json", withExtension: nil)
        else {
            fatalError("Couldn't find \("Articles_zh.json") in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \("Articles_zh.json") from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \("Articles_zh.json") as \(T.self):\n\(error)")
        }
    }

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

