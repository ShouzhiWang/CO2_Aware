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
        UserDefaults.standard.register(defaults: ["username" : ""])
        UserDefaults.standard.register(defaults: ["co2Region" : "... Please Choose"])
        UserDefaults.standard.register(defaults: ["co2e" : 0])
        UserDefaults.standard.register(defaults: ["redeemProgress" : false])
        UserDefaults.standard.register(defaults: ["stepsAuth" : false])
        healthStore = HealthStore()
        //UserDefaults.standard.register(defaults: ["appDay" : String(Date().formatted(date: .numeric, time: .omitted))])
        
    }
    
    private var healthStore: HealthStore?
    
    
    
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
    
    @Published var username: String = (UserDefaults.standard.string(forKey: "username") ?? ""){
        didSet{
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var co2Region: String = (UserDefaults.standard.string(forKey: "co2Region") ?? "...Please Choose"){
        didSet{
            UserDefaults.standard.set(co2Region, forKey: "co2Region")
        }
    }
    
    @Published var co2e: Double = (UserDefaults.standard.double(forKey: "co2e")){
        didSet{
            UserDefaults.standard.set(co2e, forKey: "co2e")
        }
    }
    
    @Published var userSteps: Double = 0.0
    
    @Published var redeemProgress: Bool = (UserDefaults.standard.bool(forKey: "redeemProgress")){
        didSet{
            UserDefaults.standard.set(redeemProgress, forKey: "redeemProgress")
        }
    }
    
    @Published var stepsAuth: Bool = (UserDefaults.standard.bool(forKey: "stepsAuth")){
        didSet{
            UserDefaults.standard.set(stepsAuth, forKey: "stepsAuth")
        }
    }
    
    
    
    @Published var appDay: String = UserDefaults.standard.string(forKey: "appDay") ?? "" {
        didSet{
            UserDefaults.standard.set(appDay, forKey: "appDay")
        }
    }
    
        
    
    

    
    func isDayChanged() {
        let todaysDate = String(Date().formatted(date: .numeric, time: .omitted))
      
        if todaysDate != UserDefaults.standard.string(forKey: "appDay") {
            
            redeemProgress = false
            appDay = todaysDate
        }
        
    }
    
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
    
    func manageSteps() {
        if let healthStore = healthStore {
            healthStore.requestAuthorization {
                success in
                if success {
                    //self.stepsAuth = true
                    
                    healthStore.getTodaysSteps { statisticCollection in
                        DispatchQueue.main.async{
                            
                            self.userSteps = statisticCollection
                        }
                        
                    }
                }
            }
        }
    }
}



