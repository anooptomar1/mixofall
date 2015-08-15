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
    var menus = [MenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        initializeMenu()
        menus = sorted(menus){$0.ordering < $1.ordering}
    }
    
    func initializeMenu(){
        menus.append(MenuModel(text: "CALayer Demo", sb: "CALDemo", order: 1))
        menus.append(MenuModel(text: "CAScrollLayer Demo", sb: "ScrollLayerApp", order: 2))
        menus.append(MenuModel(text: "CAAffineTransform Demo", sb: "Transform", order: 3))
        menus.append(MenuModel(text: "TraitCollection Demo", sb: "Trait", order: 4))
        menus.append(MenuModel(text: "UIImageView Demo", sb: "img", order: 5))
        menus.append(MenuModel(text: "CIImage Demo", sb: "CID", order: 6))
        menus.append(MenuModel(text: "UIView Demo", sb: "UID", order: 7))
        menus.append(MenuModel(text: "Geofence App", sb: "GeoF", order: 8))
        menus.append(MenuModel(text: "AddressBook App", sb: "ABAPP", order: 9))
        menus.append(MenuModel(text: "Bart API", sb: "bart", order: 10))
        menus.append(MenuModel(text: "Swift test", sb: "CT", order: 11))
        menus.append(MenuModel(text: "Animation Test", sb: "animationD", order: 12))
        menus.append(MenuModel(text: "Circular Progress", sb: "CP", order: 13))
        menus.append(MenuModel(text: "Transition1 Demo", sb: "Transition1", order: 14))
        menus.append(MenuModel(text: "Layers", sb: "LE", order: 0))
        menus.append(MenuModel(text: "Animations Explored", sb: "AE", order: 0))
        menus.append(MenuModel(text: "Transition Animation", sb: "TE", order: -1))
        menus.append(MenuModel(text: "Animation Duration", sb: "AD", order: -2))
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
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ViewController.self)) as? UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: NSStringFromClass(ViewController.self))
        }
        cell!.textLabel!.text = menus[indexPath.row].titleText
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sbName: String = menus[indexPath.row].sbName
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        let submainVC = storyboard.instantiateViewControllerWithIdentifier("subMainVC") as! UIViewController
        let navVC = UINavigationController(rootViewController: submainVC)
//        var transition = CATransition()
//        transition.type = kCATransitionPush
//        transition.duration = 10
//        transition.subtype = kCATransitionFromBottom
//        self.view.layer.addAnimation(transition, forKey: nil)
        presentViewController(navVC, animated: true, completion: nil)
    }

}

