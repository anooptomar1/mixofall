//
//  WeatherLocationsViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/2/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class WeatherLocationsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var data = [weatherCity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        getSavedData()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newLocation"{
            var vc = segue.destinationViewController as! NewWeatherViewController
            vc.delegate = self
            vc.sourceVC = self
        }
    }
    
    func getSavedData(){
        data = []
        
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(WEATHER_DATA_KEY){
            for item in savedItems{
                if let d = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as? weatherCity{
                    data.append(d)
                }
            }
        }
        
    }
    
    func setWeatherData(){
        var items = NSMutableArray()
        for d in data{
            let item = NSKeyedArchiver.archivedDataWithRootObject(d)
            items.addObject(item)
        }
        
        
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: WEATHER_DATA_KEY)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}

extension WeatherLocationsViewController: NewWeatherViewControllerDelegate{
    func didSaveNewLocation(newWeather: NewWeatherViewController, city: weatherCity) {
        data.append(city)
        setWeatherData()
        self.table.reloadData()
    }
}

extension WeatherLocationsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel!.text = data[indexPath.row].Name
        cell?.detailTextLabel!.text = data[indexPath.row].ZipCode
        
        return cell!
    }
}
