//
//  CommonCode.swift
//  pageApp
//
//  Created by Anoop tomar on 4/11/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
class Utils{
    class func getStoryBoardFromName(storyBName: String) -> UIStoryboard{
        return UIStoryboard(name: storyBName, bundle: nil)
    }
}