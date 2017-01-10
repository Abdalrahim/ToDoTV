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
//        TimeZone.ReferenceType.default = TimeZone(identifier: "America/New_York")!
//        let calendar = Calendar.current
//        
//        var dateComp:DateComponents = DateComponents()
//        dateComp.day = 10
//        dateComp.month = 01
//        dateComp.year = 2017
//        dateComp.hour = 4
//        dateComp.minute = 22
//        let date: Date = calendar.date(from: dateComp)!
//        
//        
//        let localNotificationSilent = UILocalNotification()
//        localNotificationSilent.fireDate = date
//        localNotificationSilent.timeZone = TimeZone.current
//        localNotificationSilent.alertTitle = "A new episode of 'Game of Thrones' is out"
//        localNotificationSilent.alertAction = "swipe to hear!"
//        localNotificationSilent.category = "PLAY_CATEGORY"
//        localNotificationSilent.soundName = "Note"
//        localNotificationSilent.applicationIconBadgeNumber = 1
//        UIApplication.shared.scheduleLocalNotification(localNotificationSilent)
        
//        TimeZone.ReferenceType.default = TimeZone(identifier: "Africa/Cairo")!
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone(abbreviation: "GMT")
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        let strDate = formatter.string(from: Date())
//        print(strDate)
        
//        let userCalendar = Calendar.current
//        
//        var thursday5pm18thWeek2017TokyoDateComponents = DateComponents()
//        thursday5pm18thWeek2017TokyoDateComponents.year = 2017
//        thursday5pm18thWeek2017TokyoDateComponents.month = 1
//        thursday5pm18thWeek2017TokyoDateComponents.day = 10
//        thursday5pm18thWeek2017TokyoDateComponents.hour = 11
//        thursday5pm18thWeek2017TokyoDateComponents.timeZone = TimeZone(identifier: "Africa/Cairo")
//
//        let thursday5pm18thWeek2017TokyoDate = userCalendar.date(from: thursday5pm18thWeek2017TokyoDateComponents)!
//        print(thursday5pm18thWeek2017TokyoDate)
//        
        var dateComp = DateComponents()
        dateComp.timeZone = TimeZone(identifier: "America/New_York")
        dateComp.day = 10
        dateComp.month = 01
        dateComp.year = 2017
        dateComp.hour = 4
        dateComp.minute = 36
        
        let content = UNMutableNotificationContent()
        content.title = "Uplifting Notification"
        content.subtitle = "this is a notification to wish you to.."
        content.body = ".. have a nice day/evening"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let request = UNNotificationRequest(identifier: "Quiz", content: content, trigger: trigger)
        print(request)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            error in
        })
        UpdateNextEpisodeLink.updateLink()
        UpdateEpisodes.updatedEp()
        RealmHelper.notify()
        
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
