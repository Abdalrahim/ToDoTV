//
//  UpdateNextEpisodeLink.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 9/1/17.
//  Copyright © 2017 Abdalrahim. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator


public class UpdateNextEpisodeLink {
    
    class func updateLink() {
        let series = Series()
        
        let realm = try! Realm()
        
        for i in realm.objects(Series.self) {
            
            let urlString = "\(i.link)"
            Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON() { response in
                switch response.result {
                case .success( _):
                    if let value = response.result.value {
                        
                        let json = JSON(value)
                        let retrieve = SeriesRetrieve(json: json)
                        
                        let newLink = Series()
                        newLink.link = retrieve.nextEpisode
                        RealmHelper.updateNextEpisodeLink(nextEpLinkToBeUpdated: series, newEpLink: newLink)
                        
                    }
                case .failure(let error):
                    print(error)
                    
                }
            }
            
        }
        
    }
}
