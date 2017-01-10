//
//  updateEpisodes.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 9/1/17.
//  Copyright © 2017 Abdalrahim. All rights reserved.
//

import RealmSwift
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator


public class UpdateEpisodes {
    
    class func updatedEp() {
        let series = Series()
        
        let realm = try! Realm()
        
        for i in realm.objects(Series.self) {
            
            if i.nextEpLink.characters.count == 0 {
                
            }
            else {
                let urlString = "\(i.nextEpLink)"
                Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON() { response in
                    switch response.result {
                    case .success( _):
                        if let value = response.result.value {
                            
                            let json = JSON(value)
                            
                            let retrieve = NextEpisodeDate(json: json)
                            
                            
                            let startIndexYear = retrieve.airdate.index(retrieve.airdate.startIndex, offsetBy: 0)
                            let endIndexYear = retrieve.airdate.index(retrieve.airdate.startIndex, offsetBy: 3)
                            
                            let startIndexMonth = retrieve.airdate.index(retrieve.airdate.startIndex, offsetBy: 5)
                            let endIndexMonth = retrieve.airdate.index(retrieve.airdate.startIndex, offsetBy: 6)
                            
                            let startIndexDay = retrieve.airdate.index(retrieve.airdate.startIndex, offsetBy: 8)
                            let endIndexDay = retrieve.airdate.index(retrieve.airdate.startIndex, offsetBy: 9)
                            
                            let startIndexHour = retrieve.airtime.index(retrieve.airtime.startIndex, offsetBy: 0)
                            let endIndexHour = retrieve.airtime.index(retrieve.airtime.startIndex, offsetBy: 1)
                            
                            let startIndexMin = retrieve.airtime.index(retrieve.airtime.startIndex, offsetBy: 3)
                            let endIndexMin = retrieve.airtime.index(retrieve.airtime.startIndex, offsetBy: 4)
                            
                            let newEpDate = Series()
                            
                            newEpDate.nextEpDateYear = retrieve.airdate[startIndexYear...endIndexYear]
                            newEpDate.nextEpDateMonth = retrieve.airdate[startIndexMonth...endIndexMonth]
                            newEpDate.nextEpDateDay = retrieve.airdate[startIndexDay...endIndexDay]
                            
                            newEpDate.nextEpTimeHour = retrieve.airtime[startIndexHour...endIndexHour]
                            newEpDate.nextEpTimeMinute = retrieve.airtime[startIndexMin...endIndexMin]
                            
                            RealmHelper.updateNextEpisodeDate(nextEpToBeUpdated: series, newEp: newEpDate)
                            
                            
                        }
                    case .failure(let error):
                        print(error)
                        
                    }
                }
            }
            
        }

    }
}
