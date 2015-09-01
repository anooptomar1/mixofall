//
//  ADViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/14/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {

    @IBOutlet weak var animDuration: UITextField!
    @IBOutlet weak var animRepeat: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doorPrep()
    }
    
    @IBAction func onStart(sender: UIButton) {
        //doorAnimation()
        faceAnimation()
    }
    
    func doorPrep(){
        // create a layer
        var layer = CALayer()
        layer.frame = CGRectMake(0, 0, 50, 100)
        layer.position = CGPointMake(90, 50)
        layer.anchorPoint = CGPointMake(0, 0.5)
        layer.contents = UIImage(named: "door")?.CGImage
        self.imageView.layer.addSublayer(layer)
    }
    
    func doorAnimation(){
        // apply transform
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/500.0
        self.imageView.layer.sublayerTransform = transform
        
        // applyAnimation
        var animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y"
        animation.toValue = CGFloat(M_PI_2)
        animation.duration = (self.animDuration.text as NSString).doubleValue
        animation.repeatCount = (self.animRepeat.text as NSString).floatValue
        animation.autoreverses = true
        
        self.imageView.layer.addAnimation(animation, forKey: "rotateImageAnim")
    }
    
    func faceAnimation(){
        var duration = (self.animDuration.text as NSString).doubleValue
        var repeatCount = (self.animRepeat.text as NSString).floatValue
        
        var animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.byValue = CGFloat(M_PI * 2)
        animation.delegate = self
        animation.autoreverses = true
        
        imageView.layer.addAnimation(animation, forKey: "rotateImageAnim")
        self.setControls(false)
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.setControls(true)
    }
    
    func setControls(flag: Bool){
        self.animRepeat.enabled = flag
        self.animDuration.enabled = flag
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        self.animDuration.resignFirstResponder()
        self.animRepeat.resignFirstResponder()
    }
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
