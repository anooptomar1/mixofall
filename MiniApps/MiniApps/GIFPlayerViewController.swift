//
//  GIFPlayerViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/5/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class GIFPlayerViewController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    
    var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(self.imageV)
        if translation.x > 0{
            moveFwd()
        }else{
            moveBack()
        }
    }
    
    func moveFwd(){
        if counter > 11{
            counter = 1
        }
        imageV.image = UIImage(named: "\(counter)")
        counter++
    }
    
    func moveBack(){
        if counter < 1{
            counter = 11
        }
        
        imageV.image = UIImage(named: "\(counter)")
        counter--
    }
}
