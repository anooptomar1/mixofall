//
//  CoreImageDViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/19/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CoreImageDViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filter = MyImageFilter()
        
        let image = CIImage(image: UIImage(named: "nerdy")!)
        filter.inputImage = image
        filter.inputPercentage = 0.3
        
        let output = filter.outputImage
        let outputCG = CIContext(options: nil).createCGImage(output, fromRect: output.extent)
        myImage.image = UIImage(CGImage: outputCG)
        applyBlur()
    }

    func applyBlur(){
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
        blur.frame = self.view.bounds
        blur.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        let vib = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blur.effect as! UIBlurEffect))
        blur.contentView.addSubview(vib)
        self.view.addSubview(blur)
    }
    
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
