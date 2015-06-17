//
//  TransformViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/16/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TransformViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet var sliders: [UISlider]!
    
    var v1: UIView?, v2: UIView?
    
    enum Sliders: Int{
        case rotation, scale
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let point = CGPointMake(topView.frame.size.width/2, topView.frame.size.height/2)
        v1 = UIView(frame: CGRectMake(point.x-50, point.y-50, 100, 100))
        v1!.backgroundColor = UIColor.brownColor()
        
        v2 = UIView(frame: CGRectMake(5, 5, 90, 90))
        v2!.backgroundColor = UIColor.blueColor()
        
        v1!.addSubview(v2!)
        topView.addSubview(v1!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotateView(value: Float){
        v1!.transform = CGAffineTransformMakeRotation(CGFloat(value) * CGFloat(M_PI)/180.0)
    }
    
    func scaleView(value: Float){
        v1!.transform = CGAffineTransformMakeScale(CGFloat(value), CGFloat(value))
    }

    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func onSlider(sender: UISlider){
        var theSlider = Sliders(rawValue: (sliders as NSArray).indexOfObject(sender))!
        
        switch theSlider{
        case Sliders.rotation:
            rotateView(sender.value)
        case Sliders.scale:
            scaleView(sender.value)
        default:
             break
        }
    }
    
}
