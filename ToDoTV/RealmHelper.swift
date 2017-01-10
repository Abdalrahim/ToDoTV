//
//  RealmHelper.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 21/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import RealmSwift
import UserNotifications
import UIKit

class Series : Object {
    dynamic var id = "id"
    dynamic var title = "title"
    dynamic var image = "String -> Image"
    dynamic var link = "link"
    dynamic var timezone = "timezone"
    dynamic var nextEpLink = "link"
    dynamic var nextEpDateYear = "2000"
    dynamic var nextEpDateMonth = "01"
    dynamic var nextEpDateDay = "01"
    dynamic var nextEpTimeHour = "10"
    dynamic var nextEpTimeMinute = "00"
    
}

class RealmHelper {
    static func addSeries(series: Series) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(series)
        }
        
    }
    
    static func deleteSeries(series: Series) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(series)
        }
    }
    
    static func notify() {
        let realm = try! Realm()
        for i in realm.objects(Series.self) {
            var dateComp = DateComponents()
            
            dateComp.timeZone = TimeZone(identifier: "\(i.timezone)")
            dateComp.minute = Int(i.nextEpTimeMinute)
            dateComp.hour = Int(i.nextEpTimeHour)
            dateComp.day = Int(i.nextEpDateDay)
            dateComp.month = Int(i.nextEpDateMonth)
            dateComp.year = Int(i.nextEpDateYear)
            
            let content = UNMutableNotificationContent()
            content.title = "A new Episode of \(i.title) is out!"
            content.badge = 1
            content.sound = UNNotificationSound.default()
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
            let request = UNNotificationRequest(identifier: "Quiz", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: {
                error in
            })
            
        }
        print(realm.objects(Series.self))
    }
    
    static func updateNextEpisodeDate(nextEpToBeUpdated: Series,newEp: Series) {
        let realm = try! Realm()
        try! realm.write() {
            nextEpToBeUpdated.nextEpDateYear = newEp.nextEpDateYear
            nextEpToBeUpdated.nextEpDateMonth = newEp.nextEpDateMonth
            nextEpToBeUpdated.nextEpDateDay = newEp.nextEpDateDay
            nextEpToBeUpdated.nextEpTimeHour = newEp.nextEpTimeHour
            nextEpToBeUpdated.nextEpTimeMinute = newEp.nextEpTimeMinute
        }
    }
    static func updateNextEpisodeLink(nextEpLinkToBeUpdated: Series,newEpLink: Series) {
        let realm = try! Realm()
        try! realm.write() {
            nextEpLinkToBeUpdated.nextEpLink = newEpLink.nextEpLink
        }
    }
    
    static func retrieveSeries() -> Results<Series> {
        let realm = try! Realm()
        return realm.objects(Series.self).sorted(byProperty: "title")
    }
    
    static func check(series: Series) -> Bool {
        let realm = try! Realm()
        let acopy = realm.objects(Series.self).filter("id = '\(series.id)'")
        
        if acopy.count == 0 {
            return false
        }
        else {
            return true
        }
    }
}
