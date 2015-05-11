//
//  TableDemo3ViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/10/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TableDemo3ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let kSegueID = "tabDetails"
    
    var attractionImages = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attractionNames = ["Buckingham Palace", "The Eiffel Tower", "The Grand Canyon",
            "Windsor Castle", "Empire State Building"]
        
        webAddresses = ["http://en.wikipedia.org/wiki/Buckingham_Palace", "http://en.wikipedia.org/wiki/Eiffel_Tower", "http://en.wikipedia.org/wiki/Grand_Canyon",
            "http://en.wikipedia.org/wiki/Windsor_Castle", "http://en.wikipedia.org/wiki/Empire_State_Building"]
        
        attractionImages = ["http://upload.wikimedia.org/wikipedia/en/9/93/Wizard_troll_doll-low_res.jpg",
                            "http://upload.wikimedia.org/wikipedia/commons/c/cc/Voyager_2_-_Tethys_-_3119_7858_2.png",
                            "http://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/PhilcUK-1274438506.jpg/145px-PhilcUK-1274438506.jpg",
                            "http://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Voyager_spacecraft.jpg/175px-Voyager_spacecraft.jpg",
                            "http://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Titan_3E_Centaur_launches_Voyager_2.jpg/109px-Titan_3E_Centaur_launches_Voyager_2.jpg"]
        
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.title = "Attractions"
    }
    
    func requestImageDownload(url: String, indexPath: NSIndexPath){
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if error == nil{
                let image = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), {
                    if let cellToUpdate = self.tableView.cellForRowAtIndexPath(indexPath) as? SampleTableViewCell{
                        cellToUpdate.img!.image = image
                    }
                })
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kSegueID{
            var destVC = segue.destinationViewController as! TableDetailsViewController
            destVC.webAddress = webAddresses[self.tableView.indexPathForSelectedRow()!.row]
        }
    }
}

extension TableDemo3ViewController: UITableViewDelegate{
}

extension TableDemo3ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractionNames.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? SampleTableViewCell
        cell?.img.image = UIImage(named: "Blank52")
        cell?.label.text = self.attractionNames[indexPath.row]
        requestImageDownload(attractionImages[indexPath.row], indexPath: indexPath)
        return cell!
    }
}