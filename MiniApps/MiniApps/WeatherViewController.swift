//
//  WeatherViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/2/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

let WEATHER_DATA_KEY = "weatherDataKey"

class WeatherViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    var pageVC: UIPageViewController?
    
    var data = [weatherCity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedWeatherData()
        initPageController()
    }
    
    func initPageController(){
        pageVC = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        
        pageVC?.delegate = self
        pageVC?.dataSource = self
        
        let firstVC = viewControllerAtIndex(0)!
        
        pageVC?.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.addChildViewController(pageVC!)
        self.mainView.addSubview(self.pageVC!.view)
        
        var pageRect = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height)
        pageVC!.view.frame = pageRect
        pageVC!.didMoveToParentViewController(self)
        pageVC!.automaticallyAdjustsScrollViewInsets = false
    }
    
    // helpers for page controller
    func viewControllerAtIndex(index: Int) -> WeatherTableViewController?{
        if data.count == 0 || index >= data.count{
            return nil
        }
        
        let contentVC = self.storyboard?.instantiateViewControllerWithIdentifier("contentVC") as! WeatherTableViewController
        
        contentVC.weatherContent = data[index]
        return contentVC
    }
    
    func indexOfViewController(viewController: WeatherTableViewController) -> Int{
        if let weatherData: weatherCity = viewController.weatherContent as? weatherCity{
            return (data as NSArray).indexOfObject(weatherData)
        }
        else{
            return NSNotFound
        }
    }
    
    func getSavedWeatherData(){
        data = []
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(WEATHER_DATA_KEY){
            for item in savedItems{
                if let d = NSKeyedUnarchiver.unarchiveObjectWithData(item as! NSData) as? weatherCity{
                    data.append(d)
                }
            }
        }
    }
    
    func populateTempByZip(zip: String, idx: Int){
        //http://api.openweathermap.org/data/2.5/find?q=94555&type=accurate&mode=json&units=imperial
        var url = NSURL(string: "http://api.openweathermap.org/data/2.5/find?q=\(zip)&type=accurate&mode=json&units=imperial")
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (wd, response, error) -> Void in
            if error == nil{
                var weatherData = NSJSONSerialization.JSONObjectWithData(wd, options: nil, error: nil) as! NSDictionary
                var temp = weatherCity.getTempFromWeatherJSON(weatherData)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.data[idx].Temp = temp
                })
            }
        })
        task.resume()
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

extension WeatherViewController: UIPageViewControllerDataSource{
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! WeatherTableViewController)
        if index == 0 || index == NSNotFound{
            return nil
        }
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! WeatherTableViewController)
        if index == NSNotFound{
            return nil
        }
        
        index++
        
        if index == data.count{
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
}

extension WeatherViewController: UIPageViewControllerDelegate{}
