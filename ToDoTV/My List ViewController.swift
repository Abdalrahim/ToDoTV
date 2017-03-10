//
//  ViewController.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 29/11/16.
//  Copyright © 2016 Abdalrahim. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var series = RealmHelper.retrieveSeries()
    
    override func viewDidLoad() {
        self.navigationController!.navigationBar.topItem!.title = "My List"
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        series = RealmHelper.retrieveSeries()
        UpdateNextEpisodeLink.updateLink()
        UpdateEpisodes.updatedEp()
        tableview.reloadData()
        
    }
    
    @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            RealmHelper.deleteSeries(series: series[indexPath.row])
            RealmHelper.notify()
            tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return series.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SavedSeriesViewCell
        // Configure the cell...
        
        cell.seriesTitle.text = series[indexPath.row].title
        if series[indexPath.row].nextEpDateDay.characters.count == 0 {
            cell.nextEp.text = ""
        }
        else {
            cell.nextEp.text = "next episode at \(series[indexPath.row].nextEpDateYear)/\(series[indexPath.row].nextEpDateMonth)/\(series[indexPath.row].nextEpDateDay)"
        }
        
        //decoding a string to image
        let decodedData = NSData(base64Encoded: series[indexPath.row].image, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        let decodedImage = UIImage(data: decodedData! as Data)
        
        cell.posterImage.image = decodedImage!
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSavedShow", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showSavedShow" {
                // 1
                let indexPath = tableview.indexPathForSelectedRow!
                // 2
                let show = series[indexPath.row].link
                let id = series[indexPath.row].id
                let nextEp = series[indexPath.row].nextEpLink
                let navigTitle = series[indexPath.row].title
                // 3
                let seriesPreviewController = segue.destination as! SeriesPreviewController
                // 4
                seriesPreviewController.link = show
                seriesPreviewController.id = id
                seriesPreviewController.nxtEp = nextEp
                seriesPreviewController.navigationTitle = navigTitle
            }
        }
    }



}

