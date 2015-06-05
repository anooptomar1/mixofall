//
//  NotesViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/1/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit
import CoreBluetooth

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var taskList = [MyList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskList.append(MyList(name: "Do assignment", location: "home"))
        taskList.append(MyList(name: "Go to costco", location: "Costco"))
        taskList.append(MyList(name: "Clean house", location: "home"))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg")!)
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        println(central.description)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell") as! NoteTableViewCell
        cell.setup(taskList[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Home"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue"{
            var detailsVC = segue.destinationViewController as! DetailsViewController
            var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            detailsVC.myTask = taskList[indexPath!.row]
        }
    }
}
