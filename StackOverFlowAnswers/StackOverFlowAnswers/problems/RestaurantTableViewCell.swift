//
//  RestaurantTableViewCell.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/1/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //thumbnailImageView.layer.cornerRadius = 30
        //thumbnailImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
