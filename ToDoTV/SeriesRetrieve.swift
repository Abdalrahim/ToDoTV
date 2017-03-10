//
//  SeriesRetrieve.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 10/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import SwiftyJSON

struct SeriesRetrieve {
    let id: String
    let title: String
    let type: String
    let year: String
    let rating: Double
    let time: String
    let timeZone: String
    let timeZone2: String
    let runTime: String
    let day: Array<Any>
    let status: String
    let summary: String
    let network: String
    let webNet: String
    let link: String
    let nextEpisode: String
    let previousEpisode: String
    let posterImageView: String
    let lightposter : String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["name"].stringValue
        self.type = json["type"].stringValue
        self.year = json["premiered"].stringValue
        self.rating = json["rating"]["average"].doubleValue
        self.time = json["schedule"]["time"].stringValue
        self.timeZone = json["network"]["country"]["timezone"].stringValue
        self.timeZone2 = json["webChannel"]["country"]["timezone"].stringValue
        self.runTime = json["runtime"].stringValue
        self.day = json["schedule"]["days"].arrayValue
        self.status = json["status"].stringValue
        self.summary = json["summary"].stringValue
        self.network = json["network"]["name"].stringValue
        self.webNet = json["webChannel"]["name"].stringValue
        self.link = json["_links"]["self"]["href"].stringValue
        self.nextEpisode = json["_links"]["previousepisode"]["href"].stringValue
        self.previousEpisode = json["_links"]["nextepisode"]["href"].stringValue
        self.posterImageView = json["image"]["original"].stringValue
        self.lightposter = json["image"]["medium"].stringValue
    }
}
