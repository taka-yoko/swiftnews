//
//  ViewController.swift
//  SwiftNews
//
//  Created by tyoko on 2015/10/25.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let newsUrlString = "http://www.apple.com/"
    
    @IBAction func refresh(sender: AnyObject) {
        
        let url = NSURL(string: newsUrlString)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            print("done, length \(data!.length)")
        })
        
        task.resume()
        
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("news")
        
        cell!.textLabel?.text = "Swift News"
        
        return cell!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

