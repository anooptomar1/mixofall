//
//  CBTableViewCell.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/24/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

protocol CBTableViewCellDelegate: class{
    func changedCheckboxSelection(cellController:CBTableViewCell, selected: String)
}

class CBTableViewCell: UITableViewCell {

    @IBOutlet weak var checkmark: UISwitch!
    @IBOutlet weak var title: UILabel!
    
    weak var delegate: CBTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didChangeSwitch(sender: UISwitch){
        self.delegate?.changedCheckboxSelection(self, selected: title.text!)
    }
    
}


