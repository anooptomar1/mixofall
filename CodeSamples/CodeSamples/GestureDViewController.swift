//
//  GestureDViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/17/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class GestureDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let doubleTap = UITapGestureRecognizer(target: self, action: "tapDetected")
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: "pinchDetected")
        self.view.addGestureRecognizer(pinch)
        
        let rotation = UIRotationGestureRecognizer(target: self, action: "rotationDetected:")
        self.view.addGestureRecognizer(rotation)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "panDetected")
        self.view.addGestureRecognizer(panGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeDetected")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPressDeteced")
        longPressGesture.minimumPressDuration = 3
        self.view.addGestureRecognizer(longPressGesture)
    }
    
    func longPressDeteced(){
        println("Long press detected")
    }
    
    func swipeDetected(){
        println("Swiped down")
    }
    
    func panDetected(){
        println("pan detected")
    }
    
    func rotationDetected(param: UIRotationGestureRecognizer){
        println(param.rotation)
        println("Rotation detected")
    }
    
    func tapDetected(){
        println("That sir, was double tap!")
    }
    
    func pinchDetected(){
        println("ouch!!! Don't pinch")
    }
}
