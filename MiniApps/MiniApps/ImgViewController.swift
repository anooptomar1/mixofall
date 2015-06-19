//
//  ImgViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ImgViewController: UIViewController {
    
    @IBOutlet weak var myview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupImagewithUiKit()
//        drawAnotherImage()
        drawCGImage()
    }
    
    func drawCGImage(){
        // cutting image in half and showing each part using cgimage
        var ball = UIImage(named: "ball")
        var sz = ball?.size
        // get left of image from origin to half with width as half of the image and height as height of the image
        var ballLeft = CGImageCreateWithImageInRect(ball?.CGImage, CGRectMake(0, 0, sz!.width / 2, sz!.height))
        // get right of image from half of the image to full width, width as half of the image and height as height of the image
        var ballRight = CGImageCreateWithImageInRect(ball?.CGImage, CGRectMake(sz!.width/2, 0, sz!.width/2, sz!.height))
        // open graphics context with options to define size to draw new image
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz!.width + 10, sz!.height), false, 0)
        // get current context
        var con = UIGraphicsGetCurrentContext()
        // draw image from 0,0 to half width and full height
        CGContextDrawImage(con, CGRectMake(0, 0, sz!.width / 2, sz!.height), ballLeft)
        // draw other part of image from half width + 2 to full width .. width as half of the image size and full height
        CGContextDrawImage(con, CGRectMake(sz!.width/2 + 2, 0, sz!.width / 2, sz!.height), ballRight)
        // get image out from drawn context
        var im = UIGraphicsGetImageFromCurrentImageContext()
        // close graphics context
        UIGraphicsEndImageContext()
        // create UIImageView
        var image = UIImageView(frame: CGRectMake(0, 0, sz!.width, sz!.height))
        // assign im to image
        image.image = im
        // add new uiimageview as subview of UIview
        myview.addSubview(image)
    }
    
    func drawAnotherImage(){
        var img = UIImage(named: "ball")!
        var sz = img.size
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*2, sz.height), false, 0)
        img.drawAtPoint(CGPointMake(0, 0))
        img.drawAtPoint(CGPointMake(sz.width, 0))
        var im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        var imageView = UIImageView(image: im)
        var newView = UIView(frame: CGRectMake(0, myview.bounds.size.height, sz.width, sz.height))
        newView.addSubview(imageView)
        self.view.addSubview(newView)
    }
    
    func setupImagewithUiKit(){
        // get image context
        UIGraphicsBeginImageContext(CGSizeMake(100, 100))
        // draw bezier path
        let p = UIBezierPath(ovalInRect: CGRectMake(0, 0, 100, 100))
        let p1 = UIBezierPath(rect: CGRectMake(p.bounds.size.width/2 - 35, p.bounds.size.height/2 - 12.5, 70, 25))
        
        // set fill color for bezier path
        UIColor.redColor().setFill()
        // set stroke color
        UIColor.whiteColor().setStroke()
        // set stroke
        p.stroke()
        
        // set fill
        p.fill()
        
        UIColor.whiteColor().setFill()
        p1.fill()
        
        // get image from current graphics context
        let img = UIGraphicsGetImageFromCurrentImageContext()
        // end graphics context
        UIGraphicsEndImageContext()
        // add image to image view
        let imv = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        imv.image = img
        imv.layer.borderColor = UIColor.redColor().CGColor
        imv.layer.borderWidth = 1.0
        myview.addSubview(imv)
        
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
