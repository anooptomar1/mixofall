//
//  NetworkingTestViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/3/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class NetworkingTestViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var subPages = [0:"urlSessionVC", 1:"sessionDelegateTest", 2:"multiImageVC", 3:"cancellableTask", 4: "tableViewImage"]
    var menuTitles = ["NSURLSessionDownloadTask without Delegate", "NSURLSession with Delegate", "MyDownload Test", "Cancellable task <<Memory leak>>", "TableCell image loading"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tableview.delegate = self
        tableview.dataSource = self
    }
    @IBAction func didPressDismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
extension NetworkingTestViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subPages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = menuTitles[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // push new viewcontroller on to the current navigation controller
        self.navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier(subPages[indexPath.row]!), animated: true)
    }
}
