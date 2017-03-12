//
//  ShowEpisodeLink.swift
//  ToDoTV
//
//  Created by Abdalrahim Abdullah on 12/3/17.
//  Copyright © 2017 Abdalrahim. All rights reserved.
//

import UIKit

class ShowEpisodeLink: UIViewController {
    
    
    var link: String = "apple.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let request = URL(string: "\(self.link)")
        
        web.loadRequest(URLRequest(url: request!))
        
    }
    
    @IBOutlet weak var web: UIWebView!
    
}
