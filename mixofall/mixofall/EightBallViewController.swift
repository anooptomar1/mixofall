//
//  EightBallViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/1/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class EightBallViewController: UIViewController {
    
    @IBOutlet weak var answerText: UITextView!
    
    let answers = [ "\rYES", "\rNO", "\rMAYBE",
        "I\rDON'T\rKNOW", "TRY\rAGAIN\rSOON", "READ\rTHE\rMANUAL" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fadeFortune(){
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            self.answerText.alpha = 0.0
        })
    }
    
    func newFortune(){
        let randomIndex = Int(arc4random_uniform(UInt32(answers.count)))
        answerText.text = answers[randomIndex]
        
        var a = UIResponder()
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.answerText.alpha = 1.0
        })
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if(motion == UIEventSubtype.MotionShake){
            fadeFortune()
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == UIEventSubtype.MotionShake{
            newFortune()
        }
    }
    
    override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == UIEventSubtype.MotionShake{
            newFortune()
        }
    }
}
