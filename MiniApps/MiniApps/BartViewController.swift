//
//  BartViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/10/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class BartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var parser = NSXMLParser()
    var elemName = ""
    
    var trips = [Trip]()
    var trip: Trip?
    var leg: Leg?
    
    var attributes: NSDictionary?
    
    // code to get routes
    
//    var routes = [Route]()
//    var route: Route?
    
    // code to get routes end
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let url: String = "http://api.bart.gov/api/sched.aspx?cmd=depart&orig=ucty&dest=mont&key=MW9S-E7SL-26DU-VV8V"
        let urlToSend: NSURL = NSURL(string: url)!
        
        parser = NSXMLParser(contentsOfURL: urlToSend)!
        parser.delegate = self
        let success: Bool = parser.parse()
        if success{
            print("parsing success!")
//            for t in trips{
//                for l in t.legs{
//                    println("----- leg \(l.order!) -----")
//                    println("\(l.origin!) -- \(l.destination!)")
//                    println("\(l.origTimeMin!) -- \(l.destTimeMin!)")
//                    println("\(l.line!) -- \(l.trainHeadStation!)")
//                    println("\(l.transfercode!)")
//                }
//            }
        }
        
        // code to get routes
        
//        var url: String = "http://api.bart.gov/api/route.aspx?cmd=routes&key=MW9S-E7SL-26DU-VV8V"
//        var urlToSend: NSURL = NSURL(string: url)!
//        
//        parser = NSXMLParser(contentsOfURL: urlToSend)!
//        parser.delegate = self
//        
//        var success: Bool = parser.parse()
//        
//        if success{
//            println("parse success!")
//            for r in routes{
//                println("\(r.name!) : \(r.abbr!)")
//                println("\(r.routeId!) : \(r.number!)")
//                println("Color: \(r.color!)")
//                println("---------------------->")
//            }
//        }
        
        // code to get routes end
        
    }
    
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension BartViewController: NSXMLParserDelegate{
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "trip"{
            self.trip = Trip()
        }
        if elementName == "leg"{
            self.leg = Leg()
            self.attributes = attributeDict as NSDictionary
            self.leg?.order = attributes?.objectForKey("order") as? String
            self.leg?.transfercode = attributes?.objectForKey("transfercode") as? String
            self.leg?.origin = attributes?.objectForKey("origin") as? String
            self.leg?.destination = attributes?.objectForKey("destination") as? String
            self.leg?.origTimeMin = attributes?.objectForKey("origTimeMin") as? String
            self.leg?.destTimeMin = attributes?.objectForKey("destTimeMin") as? String
            self.leg?.line = attributes?.objectForKey("line") as? String
            self.leg?.trainHeadStation = attributes?.objectForKey("trainHeadStation") as? String
            self.leg?.origDate = attributes?.objectForKey("origTimeDate") as? String
            self.leg?.destDate = attributes?.objectForKey("destTimeDate") as? String
            self.trip!.legs.append(self.leg!)
        }
        
        // code to get routes
        
//        if elementName == "route"{
//            route = Route()
//        }
//        elemName = elementName

        // code to get routes end
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "trip"{
            self.trips.append(trip!)
        }
        
        
        // code to get routes
//        if elementName == "route"{
//            routes.append(route!)
//        }
        
        // code to get routes end
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        // code to get routes
        
//        switch elemName{
//        case "name":
//            route!.name = string
//        case "abbr":
//            route!.abbr = string
//        case "routeID":
//            route!.routeId = string
//        case "number":
//            route!.number = string
//        case "color":
//            route!.color = string
//        default:
//            break
//        }
        
        // code to get routes end
    }
}

extension BartViewController: UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! BartTableViewCell
        cell.setupCell(trips[indexPath.row].legs[0])
        if trips[indexPath.row].legs.count > 1{
            cell.setupCell2(trips[indexPath.row].legs[1])
        }
        return cell
    }
}

extension BartViewController: UITableViewDelegate{}