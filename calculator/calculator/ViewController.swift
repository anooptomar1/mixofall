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
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        operandStack.append(displayValue)
        println(operandStack)
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch(operation){
            case "+":
                performOperation({$0 + $1})
            case "−":
                performOperation({$0 - $1})
            case "×":
                performOperation({$0 * $1})
            case "÷":
                performOperation({ $1 / $0 })
            case "√":
                performUnaryOperation({sqrt($0)})
            case "AC":
                clearStack()
            default: break
        }
    }
    
    func performOperation(calcOperation: (Double, Double) -> Double){
        if(operandStack.count >= 2){
            displayValue = calcOperation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performUnaryOperation(calcOperation: (Double) -> Double){
        if(operandStack.count >= 1){
            displayValue = calcOperation(operandStack.removeLast())
            enter()
        }
    }
    
    func clearStack(){
        operandStack.removeAll(keepCapacity: false)
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
        }
    }
}

