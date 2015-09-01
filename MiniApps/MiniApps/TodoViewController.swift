//
//  TodoViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/31/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
