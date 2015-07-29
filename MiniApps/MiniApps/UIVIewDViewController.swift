//
//  UIVIewDViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/19/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class UIVIewDViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
}
