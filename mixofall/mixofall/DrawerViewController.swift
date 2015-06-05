//
//  DrawerViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 2/28/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {

    var settings: SettingsView!
    
    override func viewDidLoad() {
        settings = NSBundle.mainBundle().loadNibNamed("SettingsNib", owner: self, options: nil).last as! SettingsView
        settings.frame = CGRectMake(0, -self.view.frame.size.height + 80, self.view.frame.size.width, self.view.frame.size.height)
        
        self.view.addSubview(settings)
        
        settings.setup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
