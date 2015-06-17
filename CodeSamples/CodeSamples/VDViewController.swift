//
//  VDViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 6/12/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class VDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let v = UIView(frame: CGRectMake(100, 100, 100, 100))
        let v1 = UIView(frame: CGRectMake(10, 10, 100, 100))
        let u = UIView(frame: CGRectMake(120, 120, 100, 100))
        u.backgroundColor = UIColor.blueColor()
        v1.backgroundColor = UIColor.greenColor()
        v.backgroundColor = UIColor.redColor()
        v.addSubview(v1)
        
        // rectbyInsetting
        let u1 = UIView(frame: u.bounds.rectByInsetting(dx: 10, dy: 10))
        u1.backgroundColor = UIColor.brownColor()
        u.addSubview(u1)
        self.view.addSubview(v)
        self.view.addSubview(u)
        
        v1.transform = CGAffineTransformMakeRotation(45 * CGFloat(M_PI)/180.0)
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
