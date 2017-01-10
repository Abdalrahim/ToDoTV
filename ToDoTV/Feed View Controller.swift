//
//  Feed VC.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 30/11/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar.current
        
        var dateComp:DateComponents = DateComponents()
        dateComp.day = 8
        dateComp.month = 01
        dateComp.year = 2017
        dateComp.hour = 19
        dateComp.minute = 24
        dateComp.timeZone = TimeZone(abbreviation: "SGT")
        let date: Date = calendar.date(from: dateComp)!
        
        print(date)
        
        
        
//        let localNotificationSilent = UILocalNotification()
//
//        localNotificationSilent.fireDate = date
//        localNotificationSilent.timeZone = TimeZone.current
//        localNotificationSilent.alertTitle = "A new episode of 'Game of Thrones' is out"
//        localNotificationSilent.alertAction = "swipe to hear!"
//        localNotificationSilent.category = "PLAY_CATEGORY"
//        localNotificationSilent.soundName = "Note"
//        localNotificationSilent.applicationIconBadgeNumber = 1
//        UIApplication.shared.scheduleLocalNotification(localNotificationSilent)
        
//        TimeZone.ReferenceType.default = TimeZone.current
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone.ReferenceType.default
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        let strDate = formatter.string(from: Date())
//        print(strDate)
        
//        let userCalendar = Calendar.current
//        
//        var thursday5pm18thWeek2017TokyoDateComponents = DateComponents()
//        thursday5pm18thWeek2017TokyoDateComponents.year = 2017
//        thursday5pm18thWeek2017TokyoDateComponents.month = 1
//        thursday5pm18thWeek2017TokyoDateComponents.day = 8
//        thursday5pm18thWeek2017TokyoDateComponents.hour = 22
//        thursday5pm18thWeek2017TokyoDateComponents.timeZone = TimeZone.current
//        
//        let thursday5pm18thWeek2017TokyoDate = userCalendar.date(from: thursday5pm18thWeek2017TokyoDateComponents)!
//        print(thursday5pm18thWeek2017TokyoDate)
        
        
//        NSTimeZone.default = TimeZone.current
//        var dateComp = DateComponents()
//        dateComp.timeZone = TimeZone.current
//        dateComp.day = 8
//        dateComp.month = 01
//        dateComp.year = 2017
//        dateComp.hour = 20
//        dateComp.minute = 55
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Uplifting Notification"
//        content.subtitle = "this is a notification to wish you to.."
//        content.body = ".. have a nice day/evening"
//        content.badge = 1
//        content.sound = UNNotificationSound.default()
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
//        let request = UNNotificationRequest(identifier: "Quiz", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
//            error in
//        })
        
        // Do any additional setup after loading the view, typically from a nib.
        UpdateEpisodes.updatedEp()
    }
    override func viewDidAppear(_ animated: Bool) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
