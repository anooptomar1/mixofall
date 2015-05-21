//
//  TouchIdViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/20/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIdViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.hidden = true
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Authentication required to access this app", reply: {(sucess, error) in
                if error != nil{
                    switch error!.code{
                    case LAError.SystemCancel.rawValue:
                        self.notifyUser("Session Cancelled", err: error?.localizedDescription)
                    case LAError.UserCancel.rawValue:
                        self.notifyUser("Please try again", err: error?.localizedDescription)
                    case LAError.UserFallback.rawValue:
                        self.notifyUser("Authentication", err: "Password option choosen")
                    default:
                        self.notifyUser("Authentication Failed", err: error?.localizedDescription)
                    }
                }else{
                    dispatch_async(dispatch_get_main_queue(), {
                        self.message.hidden = false
                    })
                }
            })
        }else{
            switch error!.code{
            case LAError.TouchIDNotAvailable.rawValue:
                notifyUser("Touch Id not available", err: error?.localizedDescription)
            case LAError.TouchIDNotEnrolled.rawValue:
                notifyUser("Touch Id not enrolled", err: error?.localizedDescription)
            case LAError.PasscodeNotSet.rawValue:
                notifyUser("Passcode not set", err: error?.localizedDescription)
            default:
                notifyUser("TouchID not available", err: error?.localizedDescription)
            }
        }
        
    }
    
    func notifyUser(msg:String, err: String?){
        let alert = UIAlertController(title: msg, message: err, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) -> Void in
            exit(0)
        }
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
