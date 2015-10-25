//
//  TableViewCBViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/24/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

//http://stackoverflow.com/questions/33322321/swift-adding-a-checkbox-to-every-cell-in-the-tableview

import UIKit

class TableViewCBViewController: UIViewController {

    // edit button to navigate to details controller
    @IBOutlet weak var EditButton: UIBarButtonItem!
    // save defaultTintColor
    var defaultTintColor: UIColor?
    // tableview reference
    @IBOutlet weak var tableview: UITableView!
    // sample array to hold list shown in tableview
    var items: [String] = []
    
    // array to hold selected values
    var selectedItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set scrollview to remove gap from top tableview cell
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableview.delegate = self
        self.tableview.dataSource = self
        populateItems()
        setEditButtonDefaultProperties()
    }
    
    func setEditButtonDefaultProperties(){
        // store tint color to a variable
        defaultTintColor = EditButton.tintColor!
        // set tintcolor to clearcolor to hide from user
        EditButton.tintColor = UIColor.clearColor()
        // set editbutton to false
        EditButton.enabled = false
    }

    func populateItems(){
        for i in 0..<10{
            items.append("Item \(i)")
        }
    }
  
    @IBAction func didCloseVC(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // populate detailsview controller with selected items in this view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectedDetails"{
            let destVC = segue.destinationViewController as! TableCheckDetailViewController
            destVC.selectedItems = self.selectedItems
        }
    }
}

// tablecell delegate to capture selected item in table cell
extension TableViewCBViewController: CBTableViewCellDelegate{
    // method call from delegate on switch change
    func changedCheckboxSelection(cellController: CBTableViewCell, selected: String) {
        if cellController.checkmark.on{
            // if check is on then save item in new array
            selectedItems.append(selected)
        }else{
            // if check is off then remove item from the selected array
            if let sel = selectedItems.indexOf(selected){
                selectedItems.removeAtIndex(sel)
            }
        }
        if selectedItems.count > 0{
            EditButton.tintColor = defaultTintColor!
            EditButton.enabled = true
        }else{
            EditButton.tintColor = UIColor.clearColor()
            EditButton.enabled = false
        }
    }
}

extension TableViewCBViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CBTableViewCell
        // add self as delegate for tablecell so delegate can call the function defined within
        cell.delegate = self
        cell.title.text = self.items[indexPath.row]
        return cell
    }
}
