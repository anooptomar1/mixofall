//
//  JSONParser.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/28/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class JSONParser {
    class func parse(data: NSData, inout error: NSError?) -> JSON?{
        var parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)
        if let obj: AnyObject = parsedObject{
            return JSON(parsedObject: obj)
        }
        return nil
    }
}