//
//  RatingsViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/4/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class RatingsViewController: UIViewController {
    
    
    @IBOutlet weak var yike: UIButton!
    @IBOutlet weak var good: UIButton!
    @IBOutlet weak var great: UIButton!
    var rating: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yike.transform = CGAffineTransformMakeTranslation(0, view.frame.height)
        self.good.transform = CGAffineTransformMakeTranslation(0, view.frame.height)
        self.great.transform = CGAffineTransformMakeTranslation(0, view.frame.height)
    }
    
    @IBAction func ratingSelected(sender: UIButton){
        switch sender.tag{
        case 100:
            rating = "100"
        case 200:
            rating = "200"
        case 300:
            rating = "300"
        default:
            break
        }
        performSegueWithIdentifier("unwindToDetailsView", sender: sender)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                        self.yike.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.good.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0.6, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.great.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }
}
