//
//  RealmHelper.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 21/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import RealmSwift
import UIKit

class Series : Object {
    dynamic var title = "title"
    dynamic var image = "String -> Image"
    dynamic var link = "link"
    dynamic var nextEpisode = "nxtlink"
    
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
    static func retrieveSeries() -> Results<Series> {
        let realm = try! Realm()
        return realm.objects(Series.self)
    }
    static func check(series: Series) -> Bool {
        let realm = try! Realm()
        let acopy = realm.objects(Series.self).filter("title = '\(series.title)'")
        
        if acopy.count == 0 {
            return false
        }
        else {
            return true
        }
    }
}
