//
//  DetailsTableViewController.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

class DetailsTableViewController: UITableViewController {

    var sections: NSArray!
    var hero: NSManagedObject!
    
    var saveButton: UIBarButtonItem!
    var backButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var plistUrl = NSBundle.mainBundle().URLForResource("DetailsConfiguration", withExtension: "plist")
        var plist = NSDictionary(contentsOfURL: plistUrl!)
        self.sections = plist?.valueForKey("sections") as! NSArray
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Done, target: self, action: "save")
        
        self.backButton = self.navigationItem.leftBarButtonItem
        self.cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel")
    }

    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.navigationItem.rightBarButtonItem = editing ? self.saveButton : self.editButtonItem()
        self.navigationItem.leftBarButtonItem = editing ? self.cancelButton : self.backButton
    }
    
    func save(){
        self.setEditing(false, animated: true)
        for cell in self.tableView.visibleCells(){
            let _cell = cell as! SuperDBEditCell
            self.hero!.setValue(_cell.value, forKey: _cell.key)
            
            
            var error: NSError?
            var saveSuccess = self.hero!.managedObjectContext?.save(&error)
            println("Saved \(_cell.value) : \(saveSuccess!)")
            if error != nil{
                println("Error saving: \(error?.localizedDescription)")
            }
        }
        
        self.tableView.reloadData()
    }
    func cancel(){
        println("Cancelled")
        self.setEditing(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var section = self.sections.objectAtIndex(section) as! NSDictionary
        var rows = section.objectForKey("rows") as! NSArray
        return rows.count
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (self.sections.objectAtIndex(section) as! NSDictionary).objectForKey("title") as? String
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var sectionIndex = indexPath.section
        var rowIndex = indexPath.row
        var _sections = self.sections
        
        var section = _sections.objectAtIndex(sectionIndex) as! NSDictionary
        var rows = section.objectForKey("rows") as! NSArray
        var row = rows.objectAtIndex(rowIndex) as! NSDictionary
        var cellClassName = row.valueForKey("class") as! String
        
//        let reusableCell = "heroDetailsCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellClassName) as? SuperDBEditCell
       
        if cell == nil{
            switch(cellClassName){
            case "SuperDBDateCell":
                cell = SuperDBDateCell(style: UITableViewCellStyle.Value2, reuseIdentifier: cellClassName)
            case "SuperDBPickerCell":
                cell = SuperDBPickerCell(style: UITableViewCellStyle.Value2, reuseIdentifier: cellClassName)
            default:
                cell = SuperDBEditCell(style: UITableViewCellStyle.Value2, reuseIdentifier: cellClassName)
            }
        }
        
        if let _values = row.objectForKey("values") as? NSArray{
            (cell as! SuperDBPickerCell).values = _values as [AnyObject]
        }
        
        cell?.label.text = row.objectForKey("label") as! String!
        var dataKey = row.objectForKey("key") as! String!
        cell?.textField.text = self.hero.valueForKey(dataKey) as? String
        
        
        cell?.key = dataKey
        
        return cell!
    }


    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
