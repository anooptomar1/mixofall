//
//  MenuItem.swift
//  DemoProjects
//
//  Created by Anoop tomar on 10/15/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class MenuItem {
    var title: String
    var id: Int
    var titleImage: UIImage
    var sbName: String
    
    init(title: String, id: Int, titleImage: UIImage, sbName: String){
        self.title = title
        self.id = id
        self.titleImage = titleImage
        self.sbName = sbName
    }
}
