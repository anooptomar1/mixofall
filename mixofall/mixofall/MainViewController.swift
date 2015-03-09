//
//  MainViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/8/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

var toDoList = [String]()
let kTodoList = "ToDoListKey"

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if NSUserDefaults.standardUserDefaults().objectForKey(kTodoList) != nil{
            toDoList = NSUserDefaults.standardUserDefaults().objectForKey(kTodoList) as [String]
        }
        
        // set this to remove empty lines from tableview
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as TodoTableViewCell
        cell.setCell(toDoList[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            toDoList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
            tableView.reloadData()
            NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: kTodoList)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}
