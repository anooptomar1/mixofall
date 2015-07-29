//
//  MyImageFilter.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/19/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class MyImageFilter: CIFilter {
    var inputImage: CIImage?
    var inputPercentage = NSNumber(double: 1.0)
    
    override var outputImage:CIImage!{
        get{
            return self.makeOutputImage()
        }
    }
    
    private func makeOutputImage() -> CIImage{
        // get extent for input image
        let imageExtent = self.inputImage?.extent()
        // apply gradient filter
        let gradient = CIFilter(name: "CIRadialGradient")
        // get the center of the extent
        let center = CIVector(x: imageExtent!.width / 2, y: imageExtent!.height / 2)
        // get min value between height and width
        let smallerDimention = min(imageExtent!.width, imageExtent!.height)
        // get max value between height and width
        let largerDimention = max(imageExtent!.width, imageExtent!.height)
        // set gradient center for filter
        gradient.setValue(center, forKey: "inputCenter")
        // set small value to input radius 0
        gradient.setValue(smallerDimention / 2.0 * CGFloat(self.inputPercentage.doubleValue), forKey: "inputRadius0")
        // set max value to draw outer radius
        gradient.setValue(largerDimention / 2.0, forKey: "inputRadius1")
        // get CIImage out of gradient
        let gradImage = gradient.outputImage
        // one way
        // apply new filter to blend images
//        let blend = CIFilter(name: "CIBlendWithMask")
        // blend original image
//        blend.setValue(self.inputImage, forKey: "inputImage")
        // blend gradient on input image
//        blend.setValue(gradImage, forKey: "inputMaskImage")
        // return CIImage out
//        return blend.outputImage
        // end one way
        
        // sesond way
        let blend = inputImage?.imageByApplyingFilter("CIBlendWithMask", withInputParameters: ["inputMaskImage": gradImage])
        return blend!
        // end second way
    }
}
