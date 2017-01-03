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
        var dateComp = DateComponents()
        
<<<<<<< HEAD
        dateComp.minute = 30
        dateComp.timeZone = TimeZone(abbreviation: "GMT+8")
        dateComp.hour = 18
=======
        dateComp.minute = 00
//        dateComp.timeZone = TimeZone(lo: "Asia/Dubai")
        var timeZ = TimeZone.current.identifier
        print(timeZ)
        dateComp.hour = 19
>>>>>>> origin/master
        dateComp.day = 03
        dateComp.month = 01
        dateComp.year = 2017
        
        let content = UNMutableNotificationContent()
        content.title = "Singapore"
        content.subtitle = "lel"
        content.body = "wut do yu think?"
        content.badge = 1
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let request = UNNotificationRequest(identifier: "Quiz", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            error in
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
