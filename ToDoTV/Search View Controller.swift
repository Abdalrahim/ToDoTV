//
//  Search VC.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 30/11/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTV: UISearchBar!
    
    @IBOutlet weak var resultTable: UITableView!
    
    var aseries: [SeriesSearch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTable.delegate = self
        resultTable.dataSource = self
        API()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resultTable.reloadData()
    }
    
    func API() {
        let urlString = "http://api.tvmaze.com/search/shows?q=gotham"
        Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON() { response in
            switch response.result {
            case .success( _):
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API request
                    
                    let jsonMovies = json.arrayValue
                    //var movieObjectArray: [SeriesSearch] = []
                    
                    
                    for series in jsonMovies{
                        self.aseries.append(SeriesSearch(json: series))
                    }
                    
                    
                }
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aseries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SeriesSearchTableViewCell
        // Configure the cell...
        
        cell.seriesName.text = aseries[indexPath.row].title
        
        let url = URL(string: aseries[indexPath.row].posterImageView)
        
        DispatchQueue.global().async {
            
            let data = try? Data(contentsOf: url!)
            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            if data == nil {
                
            }
            else {
                
                DispatchQueue.main.async {
                    cell.posterImage.image = UIImage(data: data!)
                }
            }
        }
        
        return cell
    }
    
    
}
