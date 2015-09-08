//
//  TodoViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/31/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
    
    let DATAKEY = "todoData"
    
    var data = [String]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        getData()
    }
    
    func getData(){
        var retrivedData = NSUserDefaults.standardUserDefaults().objectForKey(DATAKEY) as? [(String)]
        if let d = retrivedData{
            data = d
        }
    }
    
    func setData(){
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: DATAKEY)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! saveViewController
        vc.delegate = self
        vc.sourceVC = self
    }
}

extension TodoViewController: saveViewControllerDelegate{
    func didSaved(sa: saveViewController, note: String) {
        data.append(note)
        setData()
        getData()
        self.table.reloadData()
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel!.text = data[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            data.removeAtIndex(indexPath.row)
            table.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            setData()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
