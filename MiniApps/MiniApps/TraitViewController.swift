//
//  TraitViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TraitViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTraitCollection()
        setupImage2()
    }
    
    func setUpTraitCollection(){
        let tcDisp = UITraitCollection(displayScale: UIScreen.mainScreen().scale)
        let tcPhone = UITraitCollection(userInterfaceIdiom: UIUserInterfaceIdiom.Phone)
        let tcReg = UITraitCollection(verticalSizeClass: UIUserInterfaceSizeClass.Regular)
        let tc1 = UITraitCollection(traitsFromCollections: [tcDisp, tcPhone, tcReg])
        let tcComp = UITraitCollection(verticalSizeClass: UIUserInterfaceSizeClass.Compact)
        let tc2 = UITraitCollection(traitsFromCollections: [tcDisp, tcPhone, tcComp])
        let moods = UIImageAsset()
        let sadFace = UIImage(named: "sad")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let nerdyFace = UIImage(named: "nerdy")!
        moods.registerImage(sadFace, withTraitCollection: tc2)
        moods.registerImage(nerdyFace, withTraitCollection: tc1)
        // set UIImage with image
        image.image = nerdyFace
        image.tintColor = UIColor.redColor()
    }
    
    func setupImage2(){
        let img = UIImage(named: "nerdy")!
        image2.image = img.resizableImageWithCapInsets(UIEdgeInsetsMake(img.size.height / 2.0 - 1, img.size.width / 2.0 - 1, img.size.height / 2.0 - 1, img.size.width / 2.0 - 1), resizingMode: UIImageResizingMode.Stretch)
        
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
