//
//  CAMainViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/30/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CAMainViewController: UIViewController {

    
    var scaleFactor: CGFloat = 2.0
    var angle: Double = 180
    var box: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        box = UIView(frame: CGRectMake(20, 100, 50, 50))
        box?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(box!)
//        UIView.animateWithDuration(5, delay: 3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            let angle = CGFloat(90 * M_PI/180)
//            var scaleTransform = CGAffineTransformMakeScale(0.9, 0.9)
//            var rotateTransform = CGAffineTransformMakeRotation(angle)
//            self.view.transform = CGAffineTransformConcat(scaleTransform, rotateTransform)
//        }, completion: nil)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInView(self.view)
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            let scaleTransform = CGAffineTransformMakeScale(self.scaleFactor, self.scaleFactor)
            let rotateTransform = CGAffineTransformMakeRotation(CGFloat(self.angle * M_PI / 180.0))
            self.box?.transform = CGAffineTransformConcat(scaleTransform, rotateTransform)
            self.angle = (self.angle == 180 ? 360 : 180)
            self.scaleFactor = (self.scaleFactor == 2 ? 1 : 2)
            self.box!.center = location
        })
    }
}
