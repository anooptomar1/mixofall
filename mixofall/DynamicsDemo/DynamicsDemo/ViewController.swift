//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Anoop tomar on 3/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        animator.addBehavior(gravity)
        collision = UICollisionBehavior()
        collision.addBoundaryWithIdentifier("shelf", fromPoint:CGPointMake(0, 200), toPoint:CGPointMake(150, 240))
        collision.collisionDelegate = self
        
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func onTimer(){
        var randomLocation = arc4random_uniform(300)
        var snow = UIView(frame: CGRectMake(CGFloat(randomLocation), 0, 5, 5))
        snow.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(snow)
        gravity.addItem(snow)
        collision.addItem(snow)
        
    }

}

extension ViewController: UICollisionBehaviorDelegate{
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        // You have to convert the identifier to a string
        var boundary = identifier as? String
        
        // The view that collided with the boundary has to be converted to a view
        var view = item as UIView
        
        if boundary == "shelf" {
            // Detected collision with a boundary called "shelf"
        } else {
            UIView.animateWithDuration(1, animations: {
                view.alpha = 0.0
                }, completion: { finished in
                    if(finished){
                        view.removeFromSuperview()
                        self.collision.removeItem(view)
                        self.gravity.removeItem(view)
                    }
            })
        }
    }
}

