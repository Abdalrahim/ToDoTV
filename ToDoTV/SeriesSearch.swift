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
    let imdb: Double
    let year: Double
    let network: String
    let posterImageView: String
    
    
    init(json: JSON) {
        self.title = json["show"]["name"].stringValue
        self.imdb = json["show"]["rating"]["average"].doubleValue
        self.year = json["show"]["premiered"].doubleValue
        self.network = json["show"]["network"]["name"].stringValue
        self.posterImageView = json["show"]["image"]["original"].stringValue
        
    }
}
