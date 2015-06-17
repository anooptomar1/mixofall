//
//  ViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/15/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let menuItems: [String: String] = ["CALDemo": "CALayer Demo", "ScrollLayerApp":"CAScrollLayer Demo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.brownColor()
        var titleLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        titleLabel.text = "Mini Apps Menu"
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }

}

extension ViewController: UITableViewDelegate{}

extension ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ViewController.self)) as? UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: NSStringFromClass(ViewController.self))
        }
        cell!.textLabel!.text = Array(menuItems.values)[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sbName: String = Array(menuItems.keys)[indexPath.row]
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        let submainVC = storyboard.instantiateViewControllerWithIdentifier("subMainVC") as! UIViewController
        let navVC = UINavigationController(rootViewController: submainVC)
        presentViewController(navVC, animated: true, completion: nil)
    }

}

