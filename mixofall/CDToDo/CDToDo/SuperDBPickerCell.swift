//
//  SuperDBPickerCell.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/8/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class SuperDBPickerCell: SuperDBEditCell {

    var values: [AnyObject]! = []
    var picker: UIPickerView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textField.clearButtonMode = UITextFieldViewMode.Never
        self.picker = UIPickerView(frame: CGRectZero)
        self.picker.dataSource = self
        self.picker.delegate = self
        self.picker.showsSelectionIndicator = true
        
        self.textField.inputView = self.picker
    }

    override var value: AnyObject!{
        get{
            return self.textField.text as String!
        }
        set{
            if newValue != nil{
                var index = (self.values as NSArray).indexOfObject(newValue)
                if index != NSNotFound{
                    self.textField.text = newValue as! String
                }
            }else{
                self.textField.text = nil
            }
        }
    }
    
}

extension SuperDBPickerCell: UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.values.count
    }
}

extension SuperDBPickerCell: UIPickerViewDelegate{
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.values[row] as! String
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.value = self.values[row]
    }
}
