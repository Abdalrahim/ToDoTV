//
//  seriesPreview.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 7/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import CoreData
import UserNotifications
import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class SeriesPreviewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var link: String = ""
    
    var id: String = ""
    
    var nxtEp: String = ""
    
    var nxtEpDateYear: String = ""
    var nxtEpDateMonth: String = ""
    var nxtEpDateDay: String = ""
    
    var nxtEpTimeHour: String = ""
    var nxtEpTimeMinute: String = ""
    
    var sTitle: String = ""
    var navigationTitle: String = ""
    
    var lightImage: Image = #imageLiteral(resourceName: "time")
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var seriesDetails: UIScrollView!
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var seriesSummary: UITextView!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var runTime: UILabel!
    
    @IBOutlet weak var addSeries: UIButton!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBAction func addSeriesAction(_ sender: Any) {
        self.addToWatching()
    }
    
    
    
    var cast: [SeriesCast] = []
    var actorImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
        API()
        castAPI()
        nextEpDate()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView?.backgroundColor = UIColor.red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addSeries.imageView?.image! = #imageLiteral(resourceName: "add")
        self.navigationItem.title = self.navigationTitle
//        API()
//        castAPI()
//        nextEpDate()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addToWatching() {
        let series = Series()
        
        series.id = self.id
        series.title = self.sTitle
        series.nextEpDateYear = self.nxtEpDateYear
        series.nextEpDateMonth = self.nxtEpDateMonth
        series.nextEpDateDay = self.nxtEpDateDay
        series.nextEpTimeHour = self.nxtEpTimeHour
        series.nextEpTimeMinute = self.nxtEpTimeMinute
        series.nextEpLink = self.nxtEp
        series.link = self.link
        
        let imageData = UIImagePNGRepresentation(self.lightImage)
        let base64String = imageData?.base64EncodedString(options: .init(rawValue: .allZeros))
        
        series.image = base64String!
        
        if RealmHelper.check(series: series) == true {
            addSeries.imageView?.image! = #imageLiteral(resourceName: "added")
        }
        else {
            RealmHelper.addSeries(series: series)
            addSeries.imageView?.image! = #imageLiteral(resourceName: "added")
            //addedToFav.alpha = 1
        }
        
    }
    
    func checkMovie() {
        
        let series = Series()
        series.id = self.id
        
        if RealmHelper.check(series: series) == true {
            addSeries.imageView?.image! = #imageLiteral(resourceName: "added")
        }
            
        else {
            addSeries.imageView?.image! = #imageLiteral(resourceName: "add")
        }
        
    }
    
    func API() {
        loading.isHidden = false
        loading.startAnimating()
        
        let urlString = "\(self.link)"
        Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON() { response in
            switch response.result {
            case .success( _):
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    let retrieve = SeriesRetrieve(json: json)
                    
                    self.seriesSummary.text! = retrieve.summary.replacingOccurrences(of: "<p>", with: "")
                    self.seriesSummary.text! = self.seriesSummary.text!.replacingOccurrences(of: "</p>", with: "")
                    self.seriesSummary.text! = self.seriesSummary.text!.replacingOccurrences(of: "<strong>", with: "")
                    self.seriesSummary.text! = self.seriesSummary.text!.replacingOccurrences(of: "</strong>", with: "")
                    self.seriesSummary.text! = self.seriesSummary.text!.replacingOccurrences(of: "<em>", with: "")
                    self.seriesSummary.text! = self.seriesSummary.text!.replacingOccurrences(of: "</em>", with: "")
                    
                    if retrieve.rating == 0.0 {
                        self.rating.text! = "Unavailable"
                    } else {
                        self.rating.text! = String(format: "%.1f",retrieve.rating)
                    }
                    self.sTitle = retrieve.title
                    self.id = retrieve.id
                    
                    //check
                    self.checkMovie()
                    
                    self.runTime.text! = "\(retrieve.runTime) mins"
                    
                    if retrieve.status == "Running" {
                        if retrieve.day.count == 1 {
                            self.status.text! = "\(retrieve.status) | \(retrieve.day.first!) @ \(retrieve.time) | \(retrieve.network)"
                        }
                        else {
                            self.status.text! = "\(retrieve.status) | Daily @ \(retrieve.time) | \(retrieve.network)"
                        }
                    
                    } else {
                        self.status.text! = "\(retrieve.status) | \(retrieve.network)"
                    }
                    
                    
                    let url = URL(string: retrieve.posterImageView)
                    let url2 = URL(string: retrieve.lightposter)
                    
                    if url == nil {
                        self.poster.image = #imageLiteral(resourceName: "Untitled")
                        self.lightImage = #imageLiteral(resourceName: "Untitled")
                    } else {
                        DispatchQueue.global().async {
                            
                            let data = try? Data(contentsOf: url!)
                            let data2 = try? Data(contentsOf: url2!)
                            
                            if data == nil {
                                
                            }
                            else {
                                
                                DispatchQueue.main.async {
                                    self.poster.image = UIImage(data: data!)
                                }
                            }
                            
                            if data2 == nil {
                                
                            }
                            else {
                                
                                DispatchQueue.main.async {
                                    self.lightImage = UIImage(data: data2!)!
                                }
                            }
                        }
                    }
                    
                    
                    
                    self.seriesDetails.reloadInputViews()
                    
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func castAPI() {
        let urlString = "http://api.tvmaze.com/shows/\(self.id)/cast"
        Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON() { response in
            switch response.result {
            case .success( _):
                if let value = response.result.value {
                    
                    self.cast.removeAll()
                    self.actorImage.removeAll()
                    
                    let json = JSON(value)
                    
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API request
                    
                    let jsonMovies = json.arrayValue
                    
                    for series in jsonMovies{
                        self.cast.append(SeriesCast(json: series))
                    }
                    
                    for i in self.cast {
                        let url = URL(string: i.image)
                        
                        if url == nil  {
                            self.actorImage.append(#imageLiteral(resourceName: "Untitled"))
                        }
                        else {
                            
                            
                            DispatchQueue.global().sync {
                                
                                let data = try? Data(contentsOf: url!)
                                //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                
                                if data == nil {
                                    
                                }
                                else {
                                    
                                    self.actorImage.append(UIImage(data: data!)!)
                                }
                                
                            }
                        }
                    }
                    if self.cast.count == 0 {
                        self.tableView.alpha = 0
                        
                    }
                    else {
                        self.tableView.alpha = 1
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
                self.loading.isHidden = true
                self.loading.stopAnimating()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func nextEpDate() {
        let urlString = "\(self.nxtEp)"
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
                    
                    
                    self.nxtEpDateYear = retrieve.airdate[startIndexYear...endIndexYear]
                    self.nxtEpDateMonth = retrieve.airdate[startIndexMonth...endIndexMonth]
                    self.nxtEpDateDay = retrieve.airdate[startIndexDay...endIndexDay]
                    
                    self.nxtEpTimeHour = retrieve.airtime[startIndexHour...endIndexHour]
                    self.nxtEpTimeMinute = retrieve.airtime[startIndexMin...endIndexMin]
                    
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titles = ["Cast"]
        
        return titles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //tableview.sectionHeaderHeight.add(10)
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SeriesCastTableViewCell
        
        cell.actorName.text! = cast[indexPath.row].name
        
        cell.role.text! = "as \(cast[indexPath.row].role)"
        
        cell.actorImage.image = actorImage[indexPath.row]
        
        return cell
    }
}

