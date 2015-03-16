//
//  WeatherSettings.swift
//  mixofall
//
//  Created by Anoop tomar on 3/15/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class WeatherSettings: FXBlurView {
    var animator : UIDynamicAnimator!
    var container: UICollisionBehavior!
    var snap: UISnapBehavior!
    var dynamicItem: UIDynamicItemBehavior!
    var gravity: UIGravityBehavior!
    
    @IBOutlet weak var label: UILabel!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    func setup(){
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panGestureRecognizer.cancelsTouchesInView = false
        
        self.addGestureRecognizer(panGestureRecognizer)
        
        animator = UIDynamicAnimator(referenceView: self.superview!)
        dynamicItem = UIDynamicItemBehavior(items: [self])
        dynamicItem.allowsRotation = false
        dynamicItem.elasticity = 0
        animator.addBehavior(dynamicItem)
        
        gravity = UIGravityBehavior(items: [self])
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
        animator.addBehavior(gravity)
//
        container = UICollisionBehavior(items: [self])
        
        configureContainer()

        animator.addBehavior(container)
        
    }
    
    func configureContainer(){
        let boundaryWidth = UIScreen.mainScreen().bounds.size.width
        container.addBoundaryWithIdentifier("upper", fromPoint: CGPointMake(0, 20), toPoint: CGPointMake(boundaryWidth, 20))
        
        let boundaryHeight = UIScreen.mainScreen().bounds.size.height
        container.addBoundaryWithIdentifier("lower", fromPoint: CGPointMake(0, boundaryHeight + (self.frame.height - 20)), toPoint: CGPointMake(boundaryWidth,  boundaryHeight + (self.frame.height - 20) ))
    }
    
    func handlePan(pan: UIPanGestureRecognizer){
        var velocity = pan.velocityInView(self.superview).y
        
        var movement = self.frame
        movement.origin.x = 0
        movement.origin.y += velocity * 0.05
        
        if pan.state == .Ended{
            panEnded()
        } else if pan.state == .Began{
            snapToBottom()
        } else{
            animator.removeBehavior(snap)
            snap = UISnapBehavior(item: self, snapToPoint: CGPointMake(CGRectGetMidX(movement), CGRectGetMidY(movement)))
            animator.addBehavior(snap)
        }
    }
    
    func panEnded(){
        animator.removeBehavior(snap)
        
        let velocity = dynamicItem.linearVelocityForItem(self)
        
        if fabsf(Float(velocity.y)) > 250 {
            if velocity.y < 0{
                snapToTop()
            }else{
                snapToBottom()
            }
        }else{
            if let superViewHeight = self.superview?.bounds.size.height{
                if self.frame.origin.y < superViewHeight / 2{
                    snapToTop()
                }else{
                    snapToBottom()
                }
            }
        }
    }
    
    func snapToTop(){
        gravity.gravityDirection = CGVectorMake(0, -2.5)
    }
    
    func snapToBottom(){
        gravity.gravityDirection = CGVectorMake(0, 2.5)
    }
    
}
