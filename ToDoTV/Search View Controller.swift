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

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var searchTV: UISearchBar!
    
    @IBOutlet weak var resultTable: UITableView!
    
    var aseries: [SeriesSearch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTable.delegate = self
        resultTable.dataSource = self
        resultTable.alpha = 0
        
        searchTV.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            dismissKeyboard()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            resultTable.alpha = 0
        }
        else {
            resultTable.alpha = 1
        }
        API()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    
    func API() {
        var searchText = searchTV.text!
        
        if searchText.contains(" ") == true {
            
            searchText = searchText.replacingOccurrences(of: " ", with: "+")
        }
        
        let urlString = "http://api.tvmaze.com/search/shows?q=\(searchText)"
        Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON() { response in
            switch response.result {
            case .success( _):
                if let value = response.result.value {
                    
                    self.aseries.removeAll()
                    
                    let json = JSON(value)
                    
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API request
                    
                    let jsonMovies = json.arrayValue
                    
                    for series in jsonMovies{
                        self.aseries.append(SeriesSearch(json: series))
                    }
                    
                    self.resultTable.reloadData()
                    
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
        
        cell.status.text = aseries[indexPath.row].status
        
        let url = URL(string: aseries[indexPath.row].posterImageView)
        
        if url == nil  {
            cell.posterImage.image = #imageLiteral(resourceName: "Untitled")
        }
        else {
            
            
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
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSeries", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showSeries" {
                // 1
                let indexPath = resultTable.indexPathForSelectedRow!
                // 2
                let show = aseries[indexPath.row].link
                let id = aseries[indexPath.row].id
                let nextEp = aseries[indexPath.row].nextepisode
                // 3
                let seriesPreviewController = segue.destination as! SeriesPreviewController
                // 4
                seriesPreviewController.link = show
                seriesPreviewController.id = id
                seriesPreviewController.nxtEp = nextEp
            }
        }
    }
    
}
extension SearchViewController {
    
    //simple dismissing the keyboard
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
}
