//
//  VC2ViewController.swift
//  transitionDemo
//
//  Created by Anoop tomar on 8/4/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class VC2ViewController: UIViewController {
    
    @IBOutlet var displayViews: [UIView]!
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var image = UIImage(named: "numbers")
        for v in displayViews{
            v.layer.contents = image!.CGImage
            v.layer.contentsRect = CGRectMake(0.85, 0.6, 0.2, 0.4)
            v.layer.contentsGravity = kCAGravityResizeAspect
            v.layer.magnificationFilter = kCAFilterLinear
            flipTheView(v)
            UIView.animateWithDuration(5, animations: { () -> Void in
                v.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            })
        }
    }
    
    func flipTheView(v: UIView){
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/(1000.0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI), CGFloat(0), CGFloat(1), CGFloat(0))
        
        
        UIView.animateWithDuration(10, animations: { () -> Void in
            v.layer.transform = transform
        })
    }

    @IBAction func unwindcontroller(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }

}
