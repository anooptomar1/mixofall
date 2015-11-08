//
//  MultiImageViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/6/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class MultiImageViewController: UIViewController {

    @IBOutlet var ImageCollection: [UIImageView]!
    
    var counter = 0
    
    lazy var myDownloader: MyDownloader = {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.allowsCellularAccess = false
        let myDownloader = MyDownloader(config: config)
        return myDownloader
    }()
    
    var model = [Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg")]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
    }
    
    func loadImages(){
        
        for i in 0..<6{
            let m = model[i]
            if let im = m.im{
                ImageCollection[i].image = im
                continue
            }else{
                if m.task == nil{
                    myDownloader.download(m.picUrl!, completionHandler: { (url:NSURL?) -> Void in
                        guard url != nil else{
                            print("url nil")
                            return
                        }
                        let d = NSData(contentsOfURL: url!)
                        guard let data = d else{
                            print("\(i) data nil url \(url!)")
                            return
                        }
                        let im = UIImage(data: data)
                        m.im = im
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.ImageCollection[i].image = m.im!
                        })
                    })
                }
            }
        }
        print(counter)
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        myDownloader.cancelAllTasks()
    }
}
