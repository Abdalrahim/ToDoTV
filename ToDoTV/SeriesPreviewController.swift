//
//  seriesPreview.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 7/12/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class SeriesPreviewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var link: String = ""
    
    var id: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var seriesDetails: UIScrollView!
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var seriesSummary: UITextView!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    var cast: [SeriesCast] = []
    var actorImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView?.backgroundColor = UIColor.red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        API()
        castAPI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func API() {
        
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
                    
                    if url == nil {
                        self.poster.image = #imageLiteral(resourceName: "Untitled")
                    } else {
                        DispatchQueue.global().async {
                            
                            let data = try? Data(contentsOf: url!)
                            
                            if data == nil {
                                
                            }
                            else {
                                
                                DispatchQueue.main.async {
                                    self.poster.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
                    
                    self.navigationItem.title = retrieve.title
                    
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
                    
                    self.tableView.reloadData()
                    
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
        
        cell.actorImage.image = actorImage[indexPath.row]
        
        return cell
    }
}

