
//
//  BrowseViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/2/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {

    var url:String?
    
    @IBOutlet weak var web: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backToRoot")
        
        web.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
        
    }
    
    func backToRoot(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
