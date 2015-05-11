//
//  TodoCell.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/5/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.descLabel.preferredMaxLayoutWidth = self.descLabel.frame.size.width
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String, desc: String, date: String){
        self.titleLabel.text = title
        self.dueDateLabel.text = date
        self.descLabel.text = desc
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.descLabel.preferredMaxLayoutWidth = self.descLabel.frame.size.width
    }
    override func didMoveToSuperview() {
        self.layoutIfNeeded()
    }
}
