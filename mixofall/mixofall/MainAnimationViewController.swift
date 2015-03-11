//
//  MainAnimationViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/8/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class MainAnimationViewController: UIViewController {

    var greenBox: UIView?
    var redBox: UIView?
    
    var animator: UIDynamicAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dimention = CGRectMake(25, 25, 50, 50)
        greenBox = UIView(frame: dimention)
        greenBox?.backgroundColor = UIColor.greenColor()
        
        dimention = CGRectMake(130, 25, 60, 60)
        redBox = UIView(frame: dimention)
        redBox?.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(greenBox!)
        self.view.addSubview(redBox!)
        
        // init dynamic animator
        // apply physics animation to self view
        animator = UIDynamicAnimator(referenceView: self.view)
        
        // add gravity
        // init gravity behavior with objects that will be affected by the gravity
        let gravity = UIGravityBehavior(items: [greenBox!, redBox!])
        
        // create a vector to show where gravity is pointing
        var direction = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = direction
        
        // add behavior to animator
        animator?.addBehavior(gravity)
        
        // add collision
        let collesion = UICollisionBehavior(items: [greenBox!, redBox!])
        
        // set screen boundry as collision boundry
        collesion.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collesion)
        
        // add elasticity
        let elasticity = UIDynamicItemBehavior(items: [greenBox!, redBox!])
        elasticity.elasticity = 0.9
        
        animator?.addBehavior(elasticity)
        
    }


}
