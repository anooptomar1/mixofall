//
//  ListViewController.swift
//  SpringDemo
//
//  Created by Anoop tomar on 3/12/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var orangeBtn: SpringView!
    @IBOutlet weak var blueButton: SpringView!
    @IBOutlet weak var whiteButton: SpringView!
    
    var constDelay: CGFloat = 0.1
    
    @IBOutlet weak var menuView: SpringView!
    override func viewDidLoad() {
        super.viewDidLoad()
        animateView(menuView)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animateButton(orangeBtn)
        animateButton(blueButton)
        animateButton(whiteButton)
        UIApplication.sharedApplication().sendAction("minAnim", to: nil, from: self, forEvent: nil)
        
    }
    
    func animateView(view: SpringView){
        view.force = 1.0
        view.duration = 1.0
        view.delay = 0
        
        view.damping = 1.0
        view.velocity = 1.0
        view.scaleX = 1.0
        view.scaleY = 1.0
        view.x = 0
        view.y = 0
        view.rotate = 0
        
        view.animation = "pop"
        view.curve = "spring"
        view.animate()
    }
    
    func animateButton(view: SpringView){
        view.force = 1.0
        view.duration = 0.5
        constDelay += 0.2
        view.delay = constDelay
        
        view.damping = 1.0
        view.velocity = 1.0
        view.scaleX = 1.0
        view.scaleY = 1.0
        view.x = 0
        view.y = 0
        view.rotate = 10
        
        view.animation = "squeezeUp"
        view.curve = "spring"
        view.hidden = false
        view.animate()
    }
    
    @IBAction func closeView(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().sendAction("maxAnim", to: nil, from: self, forEvent: nil)

    }
}
