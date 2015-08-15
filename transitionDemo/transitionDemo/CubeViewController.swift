//
//  CubeViewController.swift
//  transitionDemo
//
//  Created by Anoop tomar on 8/10/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CubeViewController: UIViewController {

    @IBOutlet weak var leftview: UIView!
    @IBOutlet weak var rightview: UIView!
    @IBOutlet weak var middleview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateImages()
        transformImage()
        flipTheView()
    }
    
    func flipTheView(){
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/(1000.0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI), CGFloat(0), CGFloat(1), CGFloat(0))
        

        UIView.animateWithDuration(10, animations: { () -> Void in
            self.middleview.layer.transform = transform
        })
    }
    
    func populateImages(){
        var leftImage = UIImage(named: "dance")
        self.leftview.layer.contents = leftImage!.CGImage
        
        var rightImage = UIImage(named: "iron")
        self.rightview.layer.contents = rightImage!.CGImage
        
        var middleImage = UIImage(named: "la_boca")
        self.middleview.layer.contents = middleImage!.CGImage
    }
    
    func transformImage(){
        var perspective = CATransform3DIdentity
        perspective.m34 = -4.0/500.0
        
        var transform1 = CATransform3DRotate(perspective, CGFloat(M_PI_4), CGFloat(0), CGFloat(1), CGFloat(0))
        UIView.animateWithDuration(10, animations: { () -> Void in
            self.leftview.layer.transform = transform1
        })
        
        var transform2 = CATransform3DRotate(perspective, CGFloat(-M_PI_4), CGFloat(0), CGFloat(1), CGFloat(0))
        self.rightview.layer.transform = transform2
    }

    @IBAction func onClose(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
