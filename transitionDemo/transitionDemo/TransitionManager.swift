//
//  TransitionManager.swift
//  transitionDemo
//
//  Created by Anoop tomar on 8/4/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = true
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
//        let offScreenRight = CGAffineTransformMakeRotation(CGFloat(M_PI/180 * 140))
//        let offScreenLeft = CGAffineTransformMakeRotation(CGFloat(M_PI/180 * 90))
        
        if presenting{
            toView.transform = offScreenRight
        }else{
            toView.transform = offScreenLeft
        }
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            if self.presenting{
                fromView.transform = offScreenLeft
            }else{
                fromView.transform = offScreenRight
            }
            
            toView.transform = CGAffineTransformIdentity
            
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}