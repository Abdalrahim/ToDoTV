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
        
//        let timezoneConverter: Int = TimeZone.init(identifier: "America/New_York")!.secondsFromGMT() - TimeZone.current.secondsFromGMT()
        var dateComp = DateComponents()
        dateComp.day = 12
        dateComp.month = 3
        dateComp.year = 2017
        dateComp.hour = 8 //- (timezoneConverter/60/60)
        dateComp.minute = 17
        
        let content = UNMutableNotificationContent()
        content.title = "A new episode of Game of Thrones is out!"
        //content.subtitle = "A new episode Game of Thrones is out!"
        content.body = "Season 5, Episode 6"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let request = UNNotificationRequest(identifier: "kul", content: content, trigger: trigger)
        //print(trigger)
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
