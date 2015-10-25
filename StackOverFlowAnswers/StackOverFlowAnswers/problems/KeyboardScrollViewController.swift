//
//  KeyboardScrollViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/23/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class KeyboardScrollViewController: UIViewController {
    
    @IBOutlet weak var textV: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotifications()
    }
    
    
    @IBAction func didTapView(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func addNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    func keyboardWillShow(notification: NSNotification){
        if isKeyboardShown{
            return
        }
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        var viewFrame = scrollView.frame
        viewFrame.size.height -= keyboardSize.height + 100
        
        
        let keyboardAnimation = userInfo![UIKeyboardAnimationDurationUserInfoKey]!
        let keyboardAnimationCurve = UIViewAnimationCurve(rawValue: userInfo![UIKeyboardAnimationCurveUserInfoKey]! as! Int)
        UIView.beginAnimations("animation", context: nil)
        UIView.setAnimationDuration(keyboardAnimation as! NSTimeInterval)
        UIView.setAnimationCurve(keyboardAnimationCurve!)
        UIView.setAnimationBeginsFromCurrentState(true)
        scrollView.frame = viewFrame
        UIView.commitAnimations()
        isKeyboardShown = true
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        var viewFrame = scrollView.frame
        viewFrame.size.height += keyboardSize.height -  100
        
        
        let keyboardAnimation = userInfo![UIKeyboardAnimationDurationUserInfoKey]!
        let keyboardAnimationCurve = UIViewAnimationCurve(rawValue: userInfo![UIKeyboardAnimationCurveUserInfoKey]! as! Int)
        UIView.beginAnimations("animation", context: nil)
        UIView.setAnimationDuration(keyboardAnimation as! NSTimeInterval)
        UIView.setAnimationCurve(keyboardAnimationCurve!)
        UIView.setAnimationBeginsFromCurrentState(true)
        scrollView.frame = viewFrame
        UIView.commitAnimations()
        isKeyboardShown = false
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func didCloseViewController(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
