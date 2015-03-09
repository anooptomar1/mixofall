//
//  TodoTableViewCell.swift
//  mixofall
//
//  Created by Anoop tomar on 3/8/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(text: String){
        tableCell.text = text
    }

}
