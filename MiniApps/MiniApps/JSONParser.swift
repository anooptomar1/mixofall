//
//  JSONParser.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/28/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class JSONParser {
    class func parse(data: NSData) throws -> JSON{
        var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        var parsedObject: AnyObject?
        do {
            parsedObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        } catch let error1 as NSError {
            error = error1
            parsedObject = nil
        }
        if let obj: AnyObject = parsedObject{
            return JSON(parsedObject: obj)
        }
        throw error
    }
}