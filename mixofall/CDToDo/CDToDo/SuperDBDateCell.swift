//
//  SuperDBDateCell.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/8/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

let _dateFormatter = NSDateFormatter()

class SuperDBDateCell: SuperDBEditCell {


    private var datePicker: UIDatePicker!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        self.textField.clearButtonMode = UITextFieldViewMode.Never
        
        self.datePicker = UIDatePicker(frame: CGRectZero)
        self.datePicker.datePickerMode = UIDatePickerMode.Date
        
        self.datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.textField.inputView = self.datePicker
    }
    
    override var value: AnyObject!{
        get{
            if self.textField.text == nil || count(self.textField.text) == 0{
                return nil
            }else{
                return self.datePicker.date as NSDate!
            }
        }
        set{
            if let _value = newValue as? NSDate{
                self.datePicker.date = _value
                self.textField.text = _dateFormatter.stringFromDate(_value)
            }else{
                self.textField.text = nil
            }
        }
    }
    
    @IBAction func datePickerChanged(sender: AnyObject){
        var date = self.datePicker.date
        self.value = date
        self.textField.text = _dateFormatter.stringFromDate(date)
    }

}
