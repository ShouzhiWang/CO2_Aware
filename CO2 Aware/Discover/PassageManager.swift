////
////  PassageManager.swift
////  CO2 Aware
////
////  Created by 王首之 on 11/6/22.
////
//
//import Foundation
//import SwiftUI
//
//
////struct Article data type
//
//
//
//struct Article: Hashable, Codable, Identifiable {
//    var id = UUID()
//    var Title: String
//    var Date: String
//    var Author: String
//    var Content: String
//    var Link: String
//    private var ImageName: String
//    var image: Image {
//        Image(ImageName)
//    }
//
//}
//
//var articles: [Article] = load("Articles.json")
//
//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//
//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//        else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//    }
//
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}
