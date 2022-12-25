//
//  NotificationManager.swift
//  CO2 Aware
//
//  Created by 王首之 on 12/21/22.
//

import Foundation
import UserNotifications

// Manages offline push notifications
class NotificationManager {
    static let instance = NotificationManager()
    var permissionGranted = true
    
    // Request for permission
    func requestAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
                self.permissionGranted = false
            } 
        }
    }
    
    
    // Schedules for future notifications
    func scheduleNotification(title: String, name: String, hour: Int, min: Int){
        var names = ""
        if name != "" {
            names = ", " + name + "!"
        } else {
            names = "!"
        }
        let content = UNMutableNotificationContent()
        content.title = "Good \(title)\(names)"
        content.subtitle = "It's the time to do some actions!"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = min
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    
    // Cancel all planned notfications
    func cancelNotif(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
}
