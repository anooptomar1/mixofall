//
//  TEViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/13/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TEViewController: UIViewController {

    @IBOutlet weak var v: UIView!
    var imageView: UIImageView?
    
    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(frame: v.bounds)
    }

    @IBAction func onNext(sender: AnyObject) {
        addImageTransition()
    }
    func addImageTransition(){
        animationWithCustomTransition()
        //animationWithTransition()
    }
    
    func animationWithCustomTransition(){
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0.0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        var coverImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var images = [UIImage(named: "nerdy")!, UIImage(named: "sad")!, UIImage(named: "fish")!, UIImage(named: "ball")!]
        self.v.addSubview(imageView!)
        //imageView!.layer.addAnimation(transition, forKey: nil)
        
        var currentImage = imageView!.image
        var idx = 0
        if currentImage == nil{
            idx = 0
        }else{
            idx = (images as NSArray).indexOfObject(currentImage!)
        }
        idx = (idx + 1) % images.count
        
        imageView!.image = images[idx]
        
        
        var cv = UIImageView(image: coverImage)
        cv.frame = self.view.bounds
        self.view.addSubview(cv)
        
        var red = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        var green = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        var blue = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        
        var color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)

        self.view.backgroundColor = color
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            var transform = CGAffineTransformMakeScale(0.01, 0.01)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            cv.transform = transform
            cv.alpha = 0.0
            }, completion: {
                bool in
                cv.removeFromSuperview()
        })
    }
    
    func animationWithTransition(){
        var images = [UIImage(named: "nerdy")!, UIImage(named: "sad")!, UIImage(named: "fish")!, UIImage(named: "ball")!]
        
        
        imageView!.clipsToBounds = true
        // imageView.image = images[0]
        self.v.addSubview(imageView!)
        
        var transition = CATransition()
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        
        imageView!.layer.addAnimation(transition, forKey: nil)
        
        var currentImage = imageView!.image
        var idx = 0
        if currentImage == nil{
            idx = 0
        }else{
            idx = (images as NSArray).indexOfObject(currentImage!)
        }
        idx = (idx + 1) % images.count
        
        imageView!.image = images[idx]
    }

}
