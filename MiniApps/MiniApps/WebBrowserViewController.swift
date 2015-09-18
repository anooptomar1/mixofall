//
//  WebBrowserViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/2/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class WebBrowserViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var contents = ["Google": "http://www.google.com", "StackOverflow":"http://www.stackoverflow.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
        
    }

    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! BrowseViewController
        vc.url = Array(contents.values)[table.indexPathForSelectedRow!.row]
    }
    
}

extension WebBrowserViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel?.text = Array(contents.keys)[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
}


