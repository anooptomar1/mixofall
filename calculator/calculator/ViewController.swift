//
//  ViewController.swift
//  calculator
//
//  Created by Anoop tomar on 3/31/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            display.text! += digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
    }
}

