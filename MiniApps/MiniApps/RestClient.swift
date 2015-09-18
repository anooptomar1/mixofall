//
//  RestClient.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/29/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class RestClient {
    class func Get(urlString: String, callback: (JSON?, NSError?) -> ()){
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let err = error{
                callback(nil, err)
            }
            
            var parseError: NSError?
            var parsedData: JSON?
            do {
                parsedData = try JSONParser.parse(data!)
            } catch var error as NSError {
                parseError = error
                parsedData = nil
            } catch {
                fatalError()
            }
            if let err = parseError{
                callback(nil, err)
            }
            
            callback(parsedData, nil)
        })
        task.resume()
    }
    
    class func Post(urlString: String, data: [String : AnyObject], callback: (JSON?, NSError?) -> ()){
        var url = NSURL(string: urlString)!
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var paramError: NSError?
        var paramData: NSData?
        do {
            paramData = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions())
        } catch var error as NSError {
            paramError = error
            paramData = nil
        }
        request.HTTPBody = paramData
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
            if let err = error{
                callback(nil, err)
            }
            
            var parseError: NSError?
            var parseObject: JSON?
            do {
                parseObject = try JSONParser.parse(data!)
            } catch var error as NSError {
                parseError = error
                parseObject = nil
            } catch {
                fatalError()
            }
            if let err = parseError{
                callback(nil, err)
            }
            callback(parseObject, nil)
        })
        task.resume()
    }
}