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
        
        tableView.rowHeight = UITableViewAutomaticDimension
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
        cell.cellLabel.text = "dakfa kfj lsfflas f fj flsd sadf ds sd sadfslk sld fsa fsaf  sdfls ls fkd fsf slf f  flfjldfld ff dslf flk sk flks fsklf dlsk sdalkf saklfj slf sfk s;fk apofefdflk fdsa flsaf sfjlakf asklfj lfja djafl jlfka dkfjadfjdklf klsdfj sdaf ldakfl lkdajfkdlafjaklfjak dk fdasklf dfk af f sadf afdklsfjdkfd dfs faksj fldfkdsjf sfkhdhfjdvjkvjhvnvjahak ks flkasdf jdisfj sf sdjflkanflakjfaklajfs fakjfla jffjaslk"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

