//
//  WalkthroughContentViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/8/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    @IBOutlet weak var topMessage: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomMessage: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    

    var index = 0
    var heading = ""
    var imageFile = ""
    var footer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topMessage.text = heading
        imageView.image = UIImage(named: imageFile)
        bottomMessage.text = footer
        pageControl.currentPage = index
        switch index{
        case 0...1:
            btnNext.setTitle("Next", forState: UIControlState.Normal)
        case 2:
            btnNext.setTitle("Done", forState: UIControlState.Normal)
        default:
            break
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func onNextButtonClick(sender: UIButton) {
        switch index{
        case 0...1:
            if let parentController = self.parentViewController as? WalkthroughPageViewController{
                parentController.forward(index)
            }
        case 2:
            dismissViewControllerAnimated(true, completion: nil)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "DoneFoodWalkthrough")
            NSUserDefaults.standardUserDefaults().synchronize()
        default: break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
