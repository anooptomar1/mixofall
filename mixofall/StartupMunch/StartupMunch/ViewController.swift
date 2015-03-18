//
//  ViewController.swift
//  StartupMunch
//
//  Created by Anoop tomar on 3/17/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
//    var scrollHappened = false
//    var blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        var headerFrame = CGRectMake(0, 0, self.tableView.frame.width, self.tableView.frame.height - 100)
        self.tableView.tableHeaderView = UIView(frame: headerFrame)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDelegate{

}

extension ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as CellTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
}

extension ViewController: UIScrollViewDelegate{
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if(!scrollHappened){
//            
//            blurView.frame.origin.x = self.backImage.frame.origin.x
//            blurView.frame = CGRectMake(0, 0, backImage.bounds.width, self.backImage.bounds.height);
//            blurView.alpha = 0.0
//            blurView.layer
//            
//            backImage.addSubview(blurView)
//            
//            UIView.animateWithDuration(0.2, animations: { () -> Void in
//                self.blurView.frame = CGRectMake(0, 0, self.backImage.bounds.width, self.backImage.bounds.height);
//                self.blurView.alpha = 1.0
//            })
//            scrollHappened = true
//        }
//    }

//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        if(tableView.contentOffset.y <= 100.0 && scrollHappened){
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                self.blurView.frame = CGRectMake(0, 0, self.backImage.bounds.width, self.backImage.bounds.height);
//                self.blurView.alpha = 0.0
//                }, completion: { (finished) -> Void in
//                    self.blurView.removeFromSuperview()
//                    self.scrollHappened = false
//            })
//        }
//    }
}

