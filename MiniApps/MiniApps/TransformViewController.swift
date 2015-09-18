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
    
    var currentRotation: CGFloat?
    var currentScale: CGFloat?
    
    var img: UIImage?
    
    enum Sliders: Int{
        case rotation, scale, skew
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let point = CGPointMake(topView.frame.size.width/2, topView.frame.size.height/2)
        v1 = UIView(frame: CGRectMake(point.x-50, point.y-50, 100, 100))
        v1!.backgroundColor = UIColor.grayColor()
        
        v2 = UIView(frame: CGRectMake(5, 5, 90, 90))
        v2!.layer.contents = UIImage(named: "windingRoadThumbnail")?.CGImage
        
        v1!.addSubview(v2!)
        topView.addSubview(v1!)
        
        // calculator test
        
//        var calc = CalculatorBrain()
//        calc.pushOperand(20.0)
//        calc.pushOperand(30.0)
//        calc.performOperation("+")
//        calc.evaluate()
        // end calculator test
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotateView(value: Float){
        if currentScale != nil{
            let scaleTransform = CGAffineTransformMakeScale(currentScale!, currentScale!)
            let rotationTransform = CGAffineTransformMakeRotation(CGFloat(value) * CGFloat(M_PI)/180.0)
            v1?.transform = CGAffineTransformConcat(scaleTransform, rotationTransform)
        }else{
            v1?.transform = CGAffineTransformMakeRotation(CGFloat(value) * CGFloat(M_PI)/180.0)
        }
        currentRotation = CGFloat(value)
    }
    
    func scaleView(value: Float){
        if currentRotation != nil{
            let rotationTransform = CGAffineTransformMakeRotation(currentRotation!)
            let scaleTransform = CGAffineTransformMakeScale(CGFloat(value), CGFloat(value))
            v1?.transform = CGAffineTransformConcat(rotationTransform, scaleTransform)
        }else{
            v1!.transform = CGAffineTransformMakeScale(CGFloat(value), CGFloat(value))
        }
        currentScale = CGFloat(value)
    }

    func skewView(value: Float){
        v1!.transform = CGAffineTransformMake(CGFloat(value), 1.0, 1.0, 0, 0, 0)
    }
    
    @IBAction func onSnapshot(sender: UIButton) {
        img = screenShot()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imagSegue"{
            let destController = segue.destinationViewController as! SnapViewController
            destController.image = img
        }
    }
    
    func screenShot() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.mainScreen().scale)
        self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func onSlider(sender: UISlider){
        let theSlider = Sliders(rawValue: (sliders as NSArray).indexOfObject(sender))!
        
        switch theSlider{
        case Sliders.rotation:
            rotateView(sender.value)
        case Sliders.scale:
            scaleView(sender.value)
        case Sliders.skew:
            skewView(sender.value)
        default:
             break
        }
    }
    
}
