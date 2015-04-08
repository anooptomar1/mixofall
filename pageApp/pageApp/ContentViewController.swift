//
//  ContentViewController.swift
//  pageApp
//
//  Created by Anoop tomar on 4/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    var dataObject: AnyObject?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.loadHTMLString(dataObject as String, baseURL: NSURL(string: ""))
    }
}
