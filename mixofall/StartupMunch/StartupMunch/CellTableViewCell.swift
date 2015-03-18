//
//  CellTableViewCell.swift
//  StartupMunch
//
//  Created by Anoop tomar on 3/17/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {
   
    @IBOutlet weak var cellBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.cellBack.layer.cornerRadius = 14
        self.cellBack.layer.masksToBounds = true
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cellBack.layer.cornerRadius = 14
        self.cellBack.layer.masksToBounds = true
    }
    
    
}
