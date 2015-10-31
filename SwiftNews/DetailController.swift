//
//  DetailController.swift
//  SwiftNews
//
//  Created by tyoko on 2015/10/25.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    var entry = NSDictionary()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url = NSURL(string: self.entry["link"] as! String)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
    }
    
}
