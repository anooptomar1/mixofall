//
//  ViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/23/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var menuItems = [MenuItem]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        menuItems = MenuModel.getMenuItems()
        
        // remove top space from tableview row
        self.automaticallyAdjustsScrollViewInsets = false
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell!.textLabel!.text = menuItems[indexPath.row].Name
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // show new controller based on row selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presentViewController(UINavigationController(rootViewController: UIStoryboard(name: menuItems[indexPath.row].Storyboard, bundle: nil).instantiateViewControllerWithIdentifier("mainVC") as UIViewController), animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}

