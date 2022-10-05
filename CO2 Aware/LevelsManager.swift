//
//  LevelsManager.swift
//  CO2 Aware
//
//  Created by 王首之 on 10/2/22.
//

import Foundation

final class UserProgress: ObservableObject{
    
    
    init(){
        UserDefaults.standard.register(defaults: ["points" : 0])
        UserDefaults.standard.register(defaults: ["level" : 1])
        UserDefaults.standard.register(defaults: ["calculatedPoints" : 0])
    }
    
    
    @Published var points: Int = UserDefaults.standard.integer(forKey: "points"){
        didSet{
            UserDefaults.standard.set(points, forKey: "points")
            level = getCurrentLevel()
            calculatedPoints = getCurrentPoints()
        }
    }
    
    @Published var level: Int = UserDefaults.standard.integer(forKey: "level"){
        didSet{
            UserDefaults.standard.set(level, forKey: "level")
        }
    }
    
    @Published var calculatedPoints: Int = UserDefaults.standard.integer(forKey: "calculatedPoints"){
        didSet{
            UserDefaults.standard.set(calculatedPoints, forKey: "calculatedPoints")
        }
    }
        
    
    
//    func get() -> Int {
//        return UserDefaults.standard.integer(forKey: "points")
//    }
    
    func set(a: Int) {
        points = a
        UserDefaults.standard.set(a, forKey: "points")
        UserDefaults.standard.set(getCurrentLevel(), forKey: "level")
        UserDefaults.standard.set(getCurrentLevel(), forKey: "calculatedPoints")
    }
    
    func getCurrentLevel() -> Int{
        //let points = p.points
        var level = 1
        level += points/100
        if (level  <= 6){
            return level
        } else{
            return 6
        }
    }
    
    func getCurrentPoints() -> Int{
        //let points = p.points
        return points % 100
    }
}
