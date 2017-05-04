//
//  ModelName.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 13/4/17.
//  Copyright © 2017 Abdalrahim. All rights reserved.
//

import Foundation

import SwiftyJSON

struct ModelName {
    let modelName: String
    
    init(json: JSON) {
        var num = 0
        
        self.modelName = json["makes"][num]["models"][num]["name"].stringValue
    }
}

struct ModelYear {
    let modelYear: String
    
    init(json: JSON) {
        var num = 0
        self.modelYear = json["makes"][num]["models"][num]["years"][num]["year"].stringValue
    }
}
