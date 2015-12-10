//
//  AboutFoodViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/9/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit
import SafariServices

class AboutFoodViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sectionTitles = ["Leave Feedback", "Follow us"]
    var sectionContent = [["Rate our app", "Tell us about your experience"], ["Twitter", "Facebook", "Pinterest"]]
    var links = ["https://www.twitter.com", "https://www.facebook.com", "https://www.pinterest.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        title = "About Pin It"
        tableView.tableFooterView = UIView()
    }

  
}
extension AboutFoodViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1{
            switch indexPath.row{
            case 0:
                UIApplication.sharedApplication().openURL(NSURL(string: links[0])!)
            case 1:
                performSegueWithIdentifier("showWebView", sender: self)
            case 2:
                let safariController = SFSafariViewController(URL: NSURL(string: links[2])!, entersReaderIfAvailable: true)
                presentViewController(safariController, animated: true, completion: nil)
            default: break
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        cell.textLabel!.text = sectionContent[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContent[section].count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}
