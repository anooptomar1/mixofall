//
//  weatherCity.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/2/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class weatherCity: NSObject{
    
    private let NAME_KEY = "name"
    private let ZIP_KEY = "zipcode"
    private let TEMP_KEY = "temp"
    
    private var _name: String?
    private var _zipCode: String?
    private var _temp: String?
    
    var Name: String{
        return self._name!
    }
    
    var ZipCode: String{
        return self._zipCode!
    }
    
    var Temp: String{
        get{
            return _temp!
        }
        set{
            _temp = newValue
        }
    }
    
    init(coder aDecoder: NSCoder!){
        _name = aDecoder.decodeObjectForKey(NAME_KEY) as? String
        _zipCode = aDecoder.decodeObjectForKey(ZIP_KEY) as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder!){
        aCoder.encodeObject(_name, forKey: NAME_KEY)
        aCoder.encodeObject(_zipCode, forKey: ZIP_KEY)
    }
    
    init(name: String, zipcode: String){
        _name = name
        _zipCode = zipcode
    }
    
    class func getTempFromWeatherJSON(data: NSDictionary) -> String{
        let temp = (((((data["list"] as! NSArray)[0] as! NSDictionary)["main"] as! NSDictionary)["temp"]) as! Double)
        return "\(temp)"
    }
    
    class func convertJSONToWeatherCity(data: NSDictionary) -> weatherCity{
        let address_components = ((data["results"] as! NSArray)[0] as! NSDictionary)["address_components"] as! NSArray
        //println(address_components)
        // 0 as postal code
        let postalCode = (address_components[0] as! NSDictionary)["short_name"] as! String
        // 1 as city name
        let cityName = (address_components[1] as! NSDictionary)["short_name"] as! String
        // 2 as state
        let state = (address_components[2] as! NSDictionary)["short_name"] as! String
        
        return weatherCity(name: "\(cityName),\(state)", zipcode: "\(postalCode)")
    }
}