//
//  WebViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/9/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webv: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        if let url = NSURL(string: "https://www.facebook.com"){
            let request = NSURLRequest(URL: url)
            webv.loadRequest(request)
        }
    }

}
