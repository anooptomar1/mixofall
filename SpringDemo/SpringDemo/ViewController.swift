//
//  ViewController.swift
//  SpringDemo
//
//  Created by Anoop tomar on 3/12/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func minAnim(){
        spring(1, { () -> Void in
            self.view.transform = CGAffineTransformMakeScale(0.935, 0.935)
        })
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }
    func maxAnim(){
        spring(1, { () -> Void in
            self.view.transform = CGAffineTransformMakeScale(1, 1)
        })
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
    }
}

