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
        //API()
        let path =  Bundle.main.path(forResource: "Makes", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        //print(jsonData!)
        let jsonResult: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        //print(jsonResult)
        
        let json = JSON(jsonResult)
        
        let retrieve = ModelName(json: json)
        
        print(retrieve.modelName)
        
        

    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func API() {
        
        let urlString = "https://api.edmunds.com/api/vehicle/v2/makes?view=basic&fmt=json&api_key=pchttw4mrcxuc9u7dszp6g5f"
        Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON() { response in
            switch response.result {
            case .success( _):
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    let retrieve = ModelName(json: json)
                    
                    //print(retrieve.modelName)
                    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
    
    
    func notifi() {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
