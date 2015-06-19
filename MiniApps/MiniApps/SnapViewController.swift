
//
//  SnapViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {

    var image: UIImage?
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = image
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
