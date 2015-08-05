//
//  VC2ViewController.swift
//  transitionDemo
//
//  Created by Anoop tomar on 8/4/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class VC2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func unwindcontroller(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }

}
