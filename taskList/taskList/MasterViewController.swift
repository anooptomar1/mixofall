//
//  MasterViewController.swift
//  taskList
//
//  Created by Anoop tomar on 3/2/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var tasks = [TaskList]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        self.loadTasks()
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "taskListDidChange:", name: taskListDidChangeNotification, object: nil)
    }
    
    func loadTasks(){
        tasks.append(TaskList(name: "Grocery", location: "Costco"))
        tasks.append(TaskList(name: "Cleaning", location: "Home"))
    }

    func insertNewObject(sender: AnyObject) {
        var newTask: TaskList = TaskList(name: "New Task", location: "New Location")
        tasks.insert(newTask, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let task = tasks[indexPath.row] as TaskList
            (segue.destinationViewController as DetailViewController).detailItem = task
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let task = tasks[indexPath.row] as TaskList
        cell.textLabel!.text = task._name
        cell.imageView?.image = task._taskImage
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            tasks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func taskListDidChange(notification: NSNotification){
        if let changedTask = notification.object as? TaskList{
            for (index, task) in enumerate(tasks){
                if task === changedTask{
                    let path = NSIndexPath(forItem: index, inSection: 0)
                    tableView.reloadRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            }
        }
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

