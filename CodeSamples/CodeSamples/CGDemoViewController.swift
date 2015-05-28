//
//  CGDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/21/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CGDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        switch fromInterfaceOrientation{
        
        case UIInterfaceOrientation.Portrait:
            println("Phone is in portrait")
        case UIInterfaceOrientation.LandscapeLeft:
            println("Phone is in landscape left")
        case UIInterfaceOrientation.LandscapeRight:
            println("Phone is in landscape right")
        default:
            println("")
        }
    }
}
