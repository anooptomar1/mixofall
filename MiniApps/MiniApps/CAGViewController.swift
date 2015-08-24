//
//  CAGViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/20/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CAGViewController: UIViewController {

    var v: shapeLayerView!
    var vLayer: CAShapeLayer{
        return v.layer as! CAShapeLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitionViews()
        //layerClassTest()
        //usingUIViewAnimation()
       // opacityAnimationToTheLayer()
       // moveLayerByFrame()
       // groupAnimation()
    }
    
    func transitionViews(){
        var view1 = UIView(frame: CGRectMake(100,100,200,200))
        view1.backgroundColor = UIColor.redColor()
        
        var view2 = UIView(frame: CGRectMake(100,100,200,200))
        view2.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        
        view1.hidden = false
        view2.hidden = true

        var transition = CATransition()
        transition.startProgress = 0
        transition.endProgress = 1
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 5.0

        view1.layer.speed = 2

        view1.layer.addAnimation(transition, forKey: "transition")
        view2.layer.addAnimation(transition, forKey: "transition")

        view1.hidden = true
        view2.hidden = false
    }
    
    func usingUIViewAnimation(){
        UIView.animateWithDuration(5, animations: { () -> Void in
            self.v.layer.opacity = 0.0
            
            var animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(CGPoint: self.v.layer.position)
            animation.toValue = NSValue(CGPoint: CGPointMake(self.v.layer.position.x+100, self.v.layer.position.y+100))
            animation.duration = 5
            self.v.layer.addAnimation(animation, forKey: "positionAnimation")
        })
    }
    
    func groupAnimation(){
        // rotation animation
        
        var rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = M_PI*2
        
        // rotation on y
        var yAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
        yAnimation.fromValue = 0
        yAnimation.toValue = M_PI*2
        
        var groupAnim = CAAnimationGroup()
        groupAnim.animations = [rotateAnimation, yAnimation]
        groupAnim.duration = 2
        groupAnim.repeatCount = Float.infinity
        
        
        
        vLayer.addAnimation(groupAnim, forKey: "rotateAnimation")
        
        
        // border animation
    }
    
    func moveLayerByFrame(){
        var path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 74, 74)
        CGPathAddCurveToPoint(path, nil, 74, 100, 320, 100, 120, 74)
        CGPathAddCurveToPoint(path, nil, 100, 300, 366, 300, 366, 74)
        
        var animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path
        animation.duration = 5
        
        vLayer.addAnimation(animation, forKey: "MShape")
    }
    
    func opacityAnimationToTheLayer(){
        // set layer's opacity to 0 before start
        // setting this will cause image to set its opacity to 0 after animation completes
        //vLayer.opacity = 0.0
        
        //create caBasicAnimation to control animation properties
        var animation = CABasicAnimation(keyPath: "opacity")
        // animation property from value
        animation.fromValue = 0.0
        // animation property to value
        animation.toValue = 1.0
        // duration of the animation
        animation.duration = 5
        // retain property value after animation completes
        animation.removedOnCompletion = false
        // add animation to the layer
        vLayer.addAnimation(animation, forKey: "simpleOpacityAnimation")
    }
    
    func layerClassTest(){
        // init view
        v = shapeLayerView(frame: CGRectMake(100, 200, 100, 100))
        
        // add view to superview
        self.view.addSubview(v)
        
        // get shapelayer override and apply UIBezierPath
        var path = UIBezierPath(arcCenter: CGPointMake(v.bounds.size.width/2, v.bounds.size.height/2), radius: v.bounds.size.width/2, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        
        // adding path to backing layer
        vLayer.path = path.CGPath
        
        // adding stroke color to layer
        vLayer.strokeColor = UIColor.lightGrayColor().CGColor
        
        // fill color with alpha value
        vLayer.fillColor = UIColor.blueColor().colorWithAlphaComponent(0.5).CGColor
        
        // setting opaque to true to improve performance of the layer content with alpha set
        vLayer.opaque = true
        
        // line width of the stroke
        vLayer.lineWidth = 4
        
        // background image to the layer
        vLayer.contents = UIImage(named: "earth")!.CGImage
        
        // image scale property to display background with correct scale on retina dispalay
        vLayer.contentsScale = UIScreen.mainScreen().scale
        
        // layer's content image location within the layer background
        vLayer.contentsGravity = kCAGravityResizeAspect
        
    }
}
