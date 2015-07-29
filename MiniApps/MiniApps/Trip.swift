//
//  Trip.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/11/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class Trip {
    var origin: String?
    var destination: String?
    var fare: String?
    var origTimeMin: String?
    var destTimeMin: String?
    var legs = [Leg]()
}