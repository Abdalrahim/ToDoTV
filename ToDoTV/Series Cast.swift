//
//  seriesCast.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 16/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SeriesCast {
    let name: String
    let image: String
    
    init(json: JSON) {
        self.name = json["person"]["name"].stringValue
        self.image = json["person"]["image"]["medium"].stringValue
    }
}
