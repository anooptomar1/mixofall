//
//  BartTableViewCell.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/12/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class BartTableViewCell: UITableViewCell {

    @IBOutlet weak var trainColor: UIView!
    @IBOutlet weak var originDestName: UILabel!
    @IBOutlet weak var originDestTime: UILabel!
    @IBOutlet weak var trainColor2: UIView!
    @IBOutlet weak var originDestName2: UILabel!
    @IBOutlet weak var originDestTime2: UILabel!
    
    var routes = ["ROUTE 1":"#ffff33", "ROUTE 12":"#0099cc", "ROUTE 6": "#339933", "ROUTE 11" : "#0099cc","ROUTE 5" : "#339933", "ROUTE 3":"#ff9933", "ROUTE 8":"#ff0000", "ROUTE 4":"#ff9933", "ROUTE 7": "#ff0000", "ROUTE 2":"#ffff33", "ROUTE 19":"#d5cfa3","ROUTE 20" : "#d5cfa3" ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell(leg: Leg){
        originDestName.text = "\(leg.origin!) to \(leg.destination!)"
        originDestTime.text = "\(leg.origTimeMin!) to \(leg.destTimeMin!)"
        var color = routes[leg.line!]
        
        trainColor.backgroundColor = hexStringToUIColor(color!)
        
        var utcDateFormat = NSDateFormatter()
        utcDateFormat.dateFormat = "MM/dd/yyyy HH:mm"
        utcDateFormat.timeZone = NSTimeZone(abbreviation: "UTC")
        
        var range = Range(start: leg.origTimeMin!.startIndex,
            end: advance(leg.origTimeMin!.endIndex, -3))
        var or = leg.origTimeMin!.substringWithRange(range)
        
        var utcDate = utcDateFormat.dateFromString("\(leg.origDate!) \(or)")
        
       var time = NSDate(string: "\(leg.origDate!) \(leg.origTimeMin!)", formatString: "MM/dd/yyyy HH:mm a")
        println(time)
        
       // var time = moment("\(leg.origDate!) \(leg.origTimeMin!)", "MM/dd/yyyy HH:mm a", timeZone: NSTimeZone.localTimeZone(), locale: NSLocale.currentLocale())
//        println(time!.intervalSince(moment()))
        //println(utcDate)
    }
    
    func setupCell2(leg: Leg){
        originDestName2.text = "\(leg.origin!) to \(leg.destination!)"
        originDestTime2.text = "\(leg.origTimeMin!) to \(leg.destTimeMin!)"
        var color = routes[leg.line!]
        
        trainColor2.backgroundColor = hexStringToUIColor(color!)
        
        var utcDateFormat = NSDateFormatter()
        utcDateFormat.dateFormat = "MM/dd/yyyy HH:mm"
        utcDateFormat.timeZone = NSTimeZone(abbreviation: "UTC")
        
    }
    
    // Creates a UIColor from a Hex string.
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        if (count(cString) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
