//
//  SSSViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/29/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit
import AudioToolbox

class SSSViewController: UIViewController {

    var soundId = SystemSoundID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }

    
    func setupAudio(){
        let url = NSBundle.mainBundle().URLForResource("MetalBell", withExtension: "wav")!
        // Audio services is a c api
        let osStatus = AudioServicesCreateSystemSoundID(url, &soundId)
        if osStatus == noErr{
            AudioServicesPlaySystemSound(soundId)
            // play alert sound vibrates the phone
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    
    deinit{
        AudioServicesDisposeSystemSoundID(soundId)
    }

    @IBAction func dismissButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
}
