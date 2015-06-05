
//
//  DAMainViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/31/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class DAMainViewController: UIViewController {
    
    var blueBox: UIView?
    var orangeBox: UIView?
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    var elasticity: UIDynamicItemBehavior?
    var currentLocation: CGPoint?
    var attachement: UIAttachmentBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueBox = UIView(frame: CGRectMake(10, 100, 50, 50))
        blueBox?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(blueBox!)
        orangeBox = UIView(frame: CGRectMake(100, 100, 75, 75))
        orangeBox?.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(orangeBox!)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let boxAttachment = UIAttachmentBehavior(item: blueBox as! UIDynamicItem, attachedToItem: orangeBox as! UIDynamicItem)
        boxAttachment.frequency = 4.0
        boxAttachment.damping = 0.0
        
        animator?.addBehavior(boxAttachment)
        
        elasticity = UIDynamicItemBehavior(items: [blueBox!, orangeBox!])
        elasticity?.elasticity = 0.9
        animator?.addBehavior(elasticity)
        
        gravity = UIGravityBehavior(items: [blueBox!, orangeBox!])
        let vector = CGVectorMake(0.0, 0.2)
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
        
        collision = UICollisionBehavior(items: [blueBox!, orangeBox!])
        collision?.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision!)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        currentLocation = touch.locationInView(self.view)
        let offset = UIOffsetMake(20, 20)
        attachement = UIAttachmentBehavior(item: blueBox!,offsetFromCenter: offset, attachedToAnchor: currentLocation!)
        animator?.addBehavior(attachement!)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        currentLocation = touch.locationInView(self.view)
        attachement?.anchorPoint = currentLocation!
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        animator?.removeBehavior(attachement)
    }
//    
//    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
//        let touch = touches.first as! UITouch
//        let location = touch.locationInView(self.view)
//        var newBox = UIView(frame: CGRectMake(location.x, location.y, 10, 10))
//        var color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
//        newBox.backgroundColor = color
//        self.view.addSubview(newBox)
//        self.gravity?.addItem(newBox)
//        self.collision?.addItem(newBox)
//        self.elasticity?.addItem(newBox)
//    }
    
}
