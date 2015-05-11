//
//  SuperDBEditCell.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/8/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

let kLabelTextColor = UIColor(red: 0.321569, green: 0.4, blue: 0.568627, alpha: 1)

class SuperDBEditCell: UITableViewCell {

    var label: UILabel!
    var textField: UITextField!
    var key: String!
    
    var value: AnyObject!{
        get{
            return self.textField.text as String
        }
        set{
            self.textField.text = newValue as? String
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.label = UILabel(frame: CGRectMake(12, 15, 67, 15))
        self.label.backgroundColor = UIColor.clearColor()
        self.label.font = UIFont.boldSystemFontOfSize(UIFont.smallSystemFontSize())
        self.label.textColor = kLabelTextColor
        self.label.text = "Label"
        self.contentView.addSubview(self.label)
        
        self.textField = UITextField(frame: CGRectMake(93, 13, 170, 19))
        self.textField.backgroundColor = UIColor.clearColor()
        self.textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.textField.enabled = false
        self.textField.font = UIFont.boldSystemFontOfSize(UIFont.systemFontSize())
        self.textField.text = "Title"
        self.contentView.addSubview(self.textField)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        self.textField.enabled = editing
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
