//
//  AnimationDViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/3/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class AnimationDViewController: UIViewController {

    let container = UIView()
    let redSquare = UIView()
    let blueSquare = UIView()
    
    
    
    let fishView = UIImageView(image: UIImage(named: "fish"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.container.frame = CGRect(x: self.view.center.x/2, y: self.view.center.y/2, width: 200, height: 200)
        self.view.addSubview(self.container)
        
        
        self.redSquare.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.blueSquare.frame = self.redSquare.frame
        
        self.redSquare.backgroundColor = UIColor.redColor()
        self.blueSquare.backgroundColor = UIColor.blueColor()
        
        self.container.addSubview(self.redSquare)
        
        self.fishView.frame = CGRect(x: self.view.center.x/2, y: self.view.center.y + 100, width: 75, height: 50)
        self.view.addSubview(self.fishView)
        
        addSchoolOfFishes()
    }

    func addSchoolOfFishes(){
        for i in 0...5{
            let square = UIImageView(image: UIImage(named: "fish")!)
            let randomOffset = CGFloat(arc4random_uniform(150))
            
            square.frame = CGRect(x: 200, y: 500, width: Double(arc4random_uniform(20) + 50), height: Double(arc4random_uniform(40) + 40))
            //square.backgroundColor = UIColor.redColor()
            self.view.addSubview(square)
            
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: 400 + randomOffset))
            path.addCurveToPoint(CGPoint(x: self.view.frame.maxX + 100, y: 400 + randomOffset), controlPoint1: CGPoint(x: 200, y: 450 + randomOffset), controlPoint2: CGPoint(x: 300, y: 500 + randomOffset))
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = Double(arc4random_uniform(40) + 30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
            
            square.layer.addAnimation(anim, forKey: "animating position")
        }
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animateFish(){
        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModePaced
        let fullRotation = CGFloat(M_PI * 2)
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: { () -> Void in
           
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0, animations: { () -> Void in
                self.fishView.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
            })
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0, animations: { () -> Void in
                self.fishView.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
            })
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0, animations: { () -> Void in
                self.fishView.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
            })
            
            }, completion: { finished in
                
        })
    }
    
    @IBAction func onAnimate(sender: UIButton) {
        animateFish()
        var views = (frontView: self.redSquare, backView: self.blueSquare)
        //let transitionOption = UIViewAnimationOptions.TransitionCurlUp
        let transitionOption = UIViewAnimationOptions.TransitionCurlDown
        
        if((self.redSquare.superview) != nil){
            views = (frontView: self.redSquare, backView: self.blueSquare)
        }else{
            views = (frontView: self.blueSquare, backView: self.redSquare)
        }
        
//        UIView.transitionWithView(self.container, duration: 1.0, options: transitionOption, animations: { () -> Void in
//            
//            views.frontView.removeFromSuperview()
//            self.container.addSubview(views.backView)
//            }) {
//                (finished: Bool) -> Void in
//        }
        
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 1.0, options: transitionOption, completion: nil)
    }
}
