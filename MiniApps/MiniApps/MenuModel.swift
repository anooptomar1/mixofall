//
//  MenuModel.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class MenuModel {
    var titleText: String
    var sbName: String
    var ordering: Int
    
    init(text: String, sb: String, order: Int){
        self.titleText = text
        self.sbName = sb
        self.ordering = order
    }
}