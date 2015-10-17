//
//  VCCollectionViewCell.swift
//  DemoProjects
//
//  Created by Anoop tomar on 10/11/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class VCCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
