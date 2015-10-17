//
//  TextE1.swift
//  DemoProjects
//
//  Created by Anoop tomar on 10/17/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

extension String{
    public var isNotEmpty: Bool{
        return !isEmpty
    }
}

public class TextFieldEffects: UITextField{
    public let placeholderLabel = UILabel()
    
    public func animateViewsForTextEntry(){
        fatalError("\(__FUNCTION__) must be overridden")
    }
    
    public func animateViewsForTextDisplay(){
        fatalError("\(__FUNCTION__) must be overridden")
    }
    
    public func drawViewsForRect(rect: CGRect){
        fatalError("\(__FUNCTION__) must be overridden")
    }
    
    public func updateViewsForBoundsChange(bounds: CGRect){
        fatalError("\(__FUNCTION__) must be overridden")
    }
    
    public override func drawRect(rect: CGRect) {
        drawViewsForRect(rect)
    }
    
    public override func drawPlaceholderInRect(rect: CGRect) {
        
    }
    
    override public var text: String?{
        didSet{
            if let text = text where text.isNotEmpty{
                animateViewsForTextEntry()
            }else{
                animateViewsForTextDisplay()
            }
        }
    }
    
    public override func willMoveToSuperview(newSuperview: UIView?) {
        if newSuperview != nil{
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidEndEditing", name: UITextFieldTextDidEndEditingNotification, object: self)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidBeginEditing", name: UITextFieldTextDidBeginEditingNotification, object: self)
        }else{
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    public func textFieldDidEndEditing(){
        animateViewsForTextDisplay()
    }
    
    public func textFieldDidBeginEditing(){
        animateViewsForTextEntry()
    }
    
    public override func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
}
