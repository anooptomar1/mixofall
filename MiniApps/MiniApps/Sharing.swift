//
//  Sharing.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/22/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation

protocol Sharing{
    var username: String { get set }
    var error: String? { get }
    func shareMessage(message: String) -> Bool
}