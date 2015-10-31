//
//  ViewController.swift
//  SwiftNews
//
//  Created by tyoko on 2015/10/25.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //エントリーの配列
    var entries = NSArray()
    
    //ニュースサイトのアドレス
    let newsUrlString = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/rss.xml&num=8"
    
    @IBAction func refresh(sender: AnyObject) {
        
        let url = NSURL(string: newsUrlString)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let dataTask = session.dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
            if let data = data where error == nil {
                do {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String: AnyObject]
                    if let responseData = dict["responseData"] as? NSDictionary {
                        if let feed = responseData["feed"] as? NSDictionary {
                            if let entries = feed["entries"] as? NSArray {
                                self.entries = entries
                            }
                        }
                    }
                    
                }catch {
                    print("error")
                }
            }
        })
        dataTask.resume()
        
        //テーブルビューの更新をするため、メインスレッドにスイッチする
        dispatch_async(dispatch_get_main_queue(), {
            //テーブルビューの更新をする
            self.tableView.reloadData()
        })

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("news")
        
        let entry = entries[indexPath.row] as! NSDictionary
        cell?.textLabel!.text = entry["title"] as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detail", sender: entries[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let detailController = segue.destinationViewController as! DetailController
            detailController.entry = sender as! NSDictionary
        }
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

