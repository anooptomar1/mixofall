//
//  CALViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/15/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CALViewController: UIViewController {

    @IBOutlet weak var viewLayer: UIView!
    
    let layer = CALayer()
    let star = UIImage(named: "star")?.CGImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLayer.backgroundColor = UIColor.clearColor()
        setupLayer()
        // Do any additional setup after loading the view.
    }
    
    func setupLayer(){
        layer.frame = viewLayer.bounds
        layer.backgroundColor = UIColor.brownColor().CGColor
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 15
        layer.cornerRadius = 90
        layer.shadowColor = UIColor.redColor().CGColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5.0
        layer.geometryFlipped = false
        layer.drawsAsynchronously = true
        layer.contents = star
        layer.hidden = false
        layer.opacity = 1.0
        layer.contentsGravity = kCAGravityCenter
        viewLayer.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelMenu(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "controlsSegue":
                let controller = segue.destinationViewController as! ControlsTableViewController
                controller.calVC = self
                
            default:
                break
            }
        }
    }

}
