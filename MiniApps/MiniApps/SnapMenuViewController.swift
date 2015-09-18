//
//  SnapMenuViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class SnapMenuViewController: UIViewController {

    @IBOutlet weak var scrollV: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.addView1()
        self.addMenus()
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addMenus(){
        for i in 0...10{
            let v: View1 = View1(nibName: "View1", bundle: nil)
            self.addChildViewController(v)
            self.scrollV.addSubview(v.view)
            v.didMoveToParentViewController(self)
            
            let red = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
            let green = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
            let blue = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
            
            var vFrame = v.view.frame
            vFrame.origin.x = self.view.frame.width * CGFloat(i)
            v.view.frame = vFrame
            
            v.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            
            self.scrollV.contentSize = CGSizeMake(self.view.frame.width * CGFloat(i), self.view.frame.height)
        }
    }
    
    func addView1(){
        let v1: View1 = View1(nibName: "View1", bundle: nil)
        
        let v2: View2 = View2(nibName: "View2", bundle: nil)
        
        let v3: View3 = View3(nibName: "View3", bundle: nil)
        
        self.addChildViewController(v1)
        self.scrollV.addSubview(v1.view)
        v1.didMoveToParentViewController(self)
        
        self.addChildViewController(v2)
        self.scrollV.addSubview(v2.view)
        v2.didMoveToParentViewController(self)
        
        self.addChildViewController(v3)
        self.scrollV.addSubview(v3.view)
        v3.didMoveToParentViewController(self)
        
        var v2Frame = v2.view.frame
        v2Frame.origin.x = self.view.frame.width
        v2.view.frame = v2Frame
        
        var v3Frame = v3.view.frame
        v3Frame.origin.x = self.view.frame.width * 2
        v3.view.frame = v3Frame
        
        
        scrollV.contentSize = CGSizeMake(3 * self.view.frame.width, self.view.frame.height)
        
    }
}
