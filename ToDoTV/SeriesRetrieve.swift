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
    let day: Array<Any>
    let status: String
    let summary: String
    let network: String
    let posterImageView: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["name"].stringValue
        self.type = json["type"].stringValue
        self.year = json["premiered"].stringValue
        self.rating = json["rating"]["average"].doubleValue
        self.time = json["schedule"]["time"].stringValue
        self.day = json["schedule"]["days"].arrayValue
        self.status = json["status"].stringValue
        self.summary = json["summary"].stringValue
        self.network = json["network"]["name"].stringValue
        self.posterImageView = json["image"]["original"].stringValue
    }
}
