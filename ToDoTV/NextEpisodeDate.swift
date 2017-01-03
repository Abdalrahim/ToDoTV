//
//  NextEpisodeDate.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 28/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import SwiftyJSON

struct NextEpisodeDate {
    let id: String
    let url: String
    let name: String
    let season: String
    let episode: Double
    let airdate: String
    let airtime: String
    
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.url = json["url"].stringValue
        self.name = json["name"].stringValue
        self.season = json["season"].stringValue
        self.episode = json["number"].doubleValue
        self.airdate = json["airdate"].stringValue
        self.airtime = json["airtime"].stringValue
        
    }
}
