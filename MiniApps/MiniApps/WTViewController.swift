//
//  WTViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class WTViewController: UIViewController {

    @IBOutlet weak var graphV: UIView!
    @IBOutlet weak var containerV: UIView!
    @IBOutlet weak var counterV: CounterVIew!
    @IBOutlet weak var counterL: UILabel!
    
    var isGraphShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.graphV.hidden = true
    }
    @IBAction func OnClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onPlus(sender: PushButtonView) {
        if counterV.counter < numberOfGlasses{
            counterV.counter++
            counterLabel()
        }
        
        if isGraphShowing{
            counterViewTap(nil)
        }
    }
    
    @IBAction func onMinus(sender: PushButtonView) {
        if counterV.counter > 0{
            counterV.counter--
            counterLabel()
        }
    }
    
    func counterLabel(){
        counterL.text = String(counterV.counter)
    }
    
    @IBAction func counterViewTap(sender: UITapGestureRecognizer?) {
        if isGraphShowing{
            // hide graph
            UIView.transitionFromView(graphV, toView: counterV, duration: 1.0, options: [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews], completion: nil)
        }
        else{
            UIView.transitionFromView(counterV, toView: graphV, duration: 1.0, options: [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews], completion: nil)
        }
        isGraphShowing = !isGraphShowing
    }
}
