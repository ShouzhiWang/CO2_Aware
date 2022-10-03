//
//  LevelsManager.swift
//  CO2 Aware
//
//  Created by 王首之 on 10/2/22.
//

import Foundation

class UserProgress: ObservableObject{
    @Published var points: Int = 0
    
    init(){
        self.points = UserDefaults.standard.integer(forKey: "points")
    }
    
    func get() -> Int {
        return UserDefaults.standard.integer(forKey: "points")
    }
    
    func set(a: Int) {
        points = a
        UserDefaults.standard.set(a, forKey: "points")
        UserDefaults.standard.set(getCurrentLevel(), forKey: "level")
        UserDefaults.standard.set(getCurrentLevel(), forKey: "calculatedPoints")
    }
    
    func getCurrentLevel() -> String{
        //let points = p.points
        var level = 1
        level += points/100
        if (level  <= 6){
            return String(level)
        } else{
            return "6"
        }
    }
    
    func getCurrentPoints() -> Int{
        //let points = p.points
        return points % 100
    }
}
