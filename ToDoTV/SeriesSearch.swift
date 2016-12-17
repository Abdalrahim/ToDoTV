//
//  SeriesSearch.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 2/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SeriesSearch {
    let title: String
    let id: String
    let year: String
    let link: String
    let status: String
    let network: String
    let posterImageView: String
    
    init(json: JSON) {
        self.title = json["show"]["name"].stringValue
        self.id = json["show"]["id"].stringValue
        self.year = json["show"]["status"].stringValue
        self.link = json["show"]["_links"]["self"]["href"].stringValue
        self.status = json["show"]["status"].stringValue
        self.network = json["show"]["network"]["name"].stringValue
        self.posterImageView = json["show"]["image"]["medium"].stringValue
    }
}
