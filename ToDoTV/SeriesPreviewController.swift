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

class SeriesPreviewController: UIViewController {
    
    var link: String = ""
    
    @IBOutlet weak var seriesDetails: UIScrollView!
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var seriesSummary: UITextView!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var status: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        API()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    
                    
                    if retrieve.rating == "" {
                        self.rating.text! = "Unavailable"
                    } else {
                        self.rating.text! = retrieve.rating
                    }
                    
                    if retrieve.status == "Running" {
                        self.status.text! = "\(retrieve.status)|\(retrieve.network)|\(retrieve.day) @ \(retrieve.time)"
                    } else {
                        self.status.text! = retrieve.status
                    
                    }
                    
                    
                    let url = URL(string: retrieve.posterImageView)
                    
                    if url == nil {
                        self.poster.image = #imageLiteral(resourceName: "Untitled")
                    } else {
                        DispatchQueue.global().async {
                            
                            let data = try? Data(contentsOf: url!)
                            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                            
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
    
}

