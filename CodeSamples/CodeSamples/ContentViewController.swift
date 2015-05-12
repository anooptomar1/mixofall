//
//  ContentViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/10/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var dataObject: AnyObject?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.loadHTMLString(dataObject as! String, baseURL: NSURL(string: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
