//
//  CGImage2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/30/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreImage

class CGImage2D: UIView {

    override func drawRect(rect: CGRect) {
        // Draw image in rect
//        let myImage = UIImage(named: "wallpaper")
//        //let imagePoint = CGPointMake(0, 0)
//        let imageRect = UIScreen.mainScreen().bounds
//        //myImage?.drawAtPoint(imagePoint)
//        myImage?.drawInRect(imageRect)
        
        // image with color effect
        let image = UIImage(named: "wallpaper")
        let cimage = CIImage(image: image)
        
        let sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter.setDefaults()
        sepiaFilter.setValue(cimage, forKey: "inputImage")
        sepiaFilter.setValue(NSNumber(float: 0.8), forKey: "inputIntensity")
        
        let newImage = sepiaFilter.outputImage
        let context = CIContext(options: nil)
        
        let cgImage = context.createCGImage(newImage, fromRect: newImage.extent())
        let resultImage = UIImage(CGImage: cgImage)
        let imageRect = UIScreen.mainScreen().bounds
        resultImage?.drawInRect(imageRect)
    }
    
}
