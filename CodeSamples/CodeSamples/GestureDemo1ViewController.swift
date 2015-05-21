//
//  GestureDemo1ViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/19/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class GestureDemo1ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        self.statusLabel.text = "Tapped"
    }
    
    @IBAction func onPinch(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        let velocity = sender.velocity
        self.statusLabel.text = "Pinch \nScale: \(scale) \nVelocity: \(velocity)"
    }
    
    @IBAction func onRotate(sender: UIRotationGestureRecognizer) {
        let radian = sender.rotation
        let velocity = sender.velocity
        self.statusLabel.text = "Rotation \nRotation: \(radian) \nVelocity: \(velocity)"
    }
    
    @IBAction func onSwipe(sender: UISwipeGestureRecognizer) {
        let swipe = sender.direction
        switch(swipe){
        case UISwipeGestureRecognizerDirection.Down:
            self.statusLabel.text = "Swipped down"
        case UISwipeGestureRecognizerDirection.Up:
            self.statusLabel.text = "Swipped up"
        case UISwipeGestureRecognizerDirection.Right:
            self.statusLabel.text = "Swipped right"
        case UISwipeGestureRecognizerDirection.Left:
            self.statusLabel.text = "Swipped left"
        default:
            self.statusLabel.text = "Unknown swipe"
        }
    }
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
    }
    
    @IBAction func onSceen(sender: UIScreenEdgePanGestureRecognizer) {
    }
    
    @IBAction func onLongPress(sender: UILongPressGestureRecognizer) {
        self.statusLabel.text = "Long press"
    }
    
}
