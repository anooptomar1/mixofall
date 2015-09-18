//
//  TimesTableViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/31/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TimesTableViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var slider: UISlider!
    
    
    @IBAction func ValueChanged(sender: UISlider) {
        self.table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.tableFooterView = UIView()
        self.table.dataSource = self
        self.table.delegate = self
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension TimesTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(Int(slider.value * 20) * (indexPath.row + 1))
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
