//
//  AEViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/12/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class AEViewController: UIViewController {
    
    var v = UIView(frame: CGRectMake(300, 100, 50, 100))
    var cl = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followPath()
        //self.animatedColors()
    }

    func followPath(){
        
        // view that will hold all components
        var v = UIView(frame: CGRectMake(0, 100, 300, 600))
        //v.backgroundColor = UIColor.redColor()
        self.view.addSubview(v)
        
        // path to follow
        var path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 150))
        path.addCurveToPoint(CGPointMake(100, 150), controlPoint1: CGPointMake(50, 0), controlPoint2: CGPointMake(75, 200))
        path.moveToPoint(CGPointMake(100, 150))
        path.addCurveToPoint(CGPointMake(200, 150), controlPoint1: CGPointMake(150, 50), controlPoint2: CGPointMake(175, 200))
        
        path.moveToPoint(CGPointMake(200, 150))
        path.addCurveToPoint(CGPointMake(400, 150), controlPoint1: CGPointMake(250, 100), controlPoint2: CGPointMake(300, 200))
        
        // layer to print path
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.lineWidth = 3.0
        
        v.layer.addSublayer(shapeLayer)
        
        // object that will follow path
        var fishLayer = CALayer()
        fishLayer.frame = CGRectMake(0, 0, 50, 25)
        fishLayer.position = CGPointMake(0, 150)
        fishLayer.contents = UIImage(named: "fish")?.CGImage
        fishLayer.backgroundColor = UIColor.blueColor().CGColor
        
        v.layer.addSublayer(fishLayer)
        
        // keyframe animation
        var animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        // instead using duration of 4 sec from animation group
        // animation.duration = 4.0
        animation.path = path.CGPath
        animation.rotationMode = kCAAnimationRotateAuto
       // animation.repeatCount = Float.infinity
        
        // color animation
        var colorAnimation = CABasicAnimation()
        colorAnimation.keyPath = "backgroundColor"
        colorAnimation.toValue = UIColor.redColor().CGColor
        //colorAnimation.repeatCount = Float.infinity
        
        // group animation
        var groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, colorAnimation]
        groupAnimation.duration = 4.0
        groupAnimation.repeatCount = Float.infinity
        
        fishLayer.addAnimation(groupAnimation, forKey: nil)
        
    }
    
    func animatedColors(){
        cl.frame = v.bounds
        cl.backgroundColor = UIColor.redColor().CGColor
        
//        var transition = CATransition()
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromRight
//        cl.actions = ["backgroundColor":transition]
        
        v.layer.addSublayer(cl)
        self.view.addSubview(v)
        
        
        
        // button
        var button = UIButton(frame: CGRectMake(100, 150, 50, 25))
        button.setTitle("OK", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.grayColor()
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        var touchPoint = (touches.first as! UITouch).locationInView(self.view)
//        
//        var test = (self.cl.presentationLayer() as! CALayer).hitTest(touchPoint)
//        
//        if( test == nil){
//            var red = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
//            var green = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
//            var blue = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
//            self.cl.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0).CGColor
//        }
//        else{
//            CATransaction.begin()
//            CATransaction.setAnimationDuration(4.0)
//            self.cl.position = touchPoint
//            CATransaction.commit()
//        }
//    }
    
    func applyBasicAnimation(canimation: CABasicAnimation, var calayer: CALayer){
        var layer = calayer
        if let l = calayer.presentationLayer() as? CALayer{
            layer = l
        }
        
        canimation.fromValue = layer.backgroundColor
        
        canimation.setValue(cl, forKey: "colorAnim")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        calayer.setValue(canimation.toValue, forKey: canimation.keyPath)
        CATransaction.commit()
        
        calayer.addAnimation(canimation, forKey: nil)
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        var v = anim.valueForKey("colorAnim") as! CALayer
        v.backgroundColor = (anim as! CABasicAnimation).toValue as! CGColor
        CATransaction.commit()
    }
    
    func buttonClicked(sender: UIButton){
        keyframeAnimation()
    }
    
    func keyframeAnimation(){
        var animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 10.0
        animation.values = [
            UIColor.blueColor().CGColor,
            UIColor.blackColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.blueColor().CGColor
        ]
        
        
        cl.addAnimation(animation, forKey: nil)
    }
    
    func basicAnimation(){
        
        
                var red = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
                var green = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
                var blue = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        
                var color = UIColor(red: red, green: green, blue: blue, alpha: 1.0).CGColor
        
                var animation = CABasicAnimation()
                animation.duration = 1
                animation.keyPath = "backgroundColor"
                animation.toValue = color
                animation.delegate = self
        
               applyBasicAnimation(animation, calayer: cl)
        
        //        CATransaction.begin()
        //        CATransaction.setAnimationDuration(1)
        //
        //        cl.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0).CGColor
        
        //        uncomment below to see line drawn on screen
        
        //        var path = UIBezierPath()
        //        path.moveToPoint(CGPointMake(CGFloat(arc4random_uniform(200)), CGFloat(arc4random_uniform(500))))
        //        path.addLineToPoint(CGPointMake(CGFloat(arc4random_uniform(200)), CGFloat(arc4random_uniform(500))))
        //
        //        var shapeLayer = CAShapeLayer()
        //        shapeLayer.path = path.CGPath
        //        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        //        shapeLayer.lineWidth = 4
        //        shapeLayer.lineJoin = kCALineJoinRound
        //        shapeLayer.lineCap = kCALineCapRound
        
        //        cl.addSublayer(shapeLayer)
        
        // uncomment to see animation after animation complete
        
        //        CATransaction.setCompletionBlock { () -> Void in
        //            var transform = self.cl.affineTransform()
        //            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        //            self.cl.transform = CATransform3DMakeAffineTransform(transform)
        //        }
        
        //        CATransaction.commit()

    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
