//
//  CancellableTaskViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/6/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class Model{
    var title: String?
    var im: UIImage?
    var picUrl: String?
    var task: NSURLSessionTask?
    init(_title: String, _url: String){
        self.title = _title
        self.picUrl = _url
    }
}


// NSURLSession is memory leak causing
class CancellableTaskViewController: UIViewController {

    var modalUrls = [Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
    Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
    Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
    Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
    Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
    Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg"),
        Model(_title: "Star wars 1", _url: "https://atomicanxiety.files.wordpress.com/2013/12/star-wars-episode-1-poster.jpg"),
        Model(_title: "Star wars 2", _url: "http://moviefiles.alphacoders.com/953/poster-953.jpg"),
        Model(_title: "Star wars 3", _url: "http://static.cinemagia.ro/img/db/movie/00/50/19/star-wars-episode-iii-revenge-of-the-sith-650732l.jpg"),
        Model(_title: "Star wars 4", _url: "http://cdn.screenrant.com/wp-content/uploads/Star-Wars-The-Force-Awakens-stormtrooper-poster.jpg"),
        Model(_title: "Star wars 5", _url: "http://i.jeded.com/i/star-wars-episode-v--the-empire-strikes-back.13948.jpg"),
        Model(_title: "Star wars 6", _url: "http://simonz.co.hu/poster/ep456/ep6-poster1.jpg")]
    
    
    
    lazy var myDownloader: MyDownloader = {
        //let config = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("com.devtechie.stackoverflow")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.URLCache = NSURLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        config.allowsCellularAccess = false
        let mydownloader = MyDownloader(config: config)
        return mydownloader
    }()
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        myDownloader.cancelAllTasks()
        
    }
    
}

extension CancellableTaskViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        let onePoster = modalUrls[indexPath.row]
        cell!.textLabel!.text = onePoster.title!
        if let m = onePoster.im{
            cell!.imageView!.image = m
        }else{
            if onePoster.task == nil{
                onePoster.task = myDownloader.download(modalUrls[indexPath.row].picUrl!, completionHandler: {
                    [weak self]
                    (url: NSURL?) -> Void in
                    guard url != nil else{
                        print("url is nil")
                        return
                    }
                    let d = NSData(contentsOfURL: url!)
                    guard d != nil else{
                        print("data of url is nil")
                        return
                    }
                    let im = UIImage(data: d!)
                    onePoster.im = im
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self!.tableview.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                    })
                    })!
            }
        }
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modalUrls.count
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let m = modalUrls[indexPath.row]
        if let task = m.task{
            if task.state == NSURLSessionTaskState.Running{
                task.cancel()
                m.task = nil
            }
        }
    }
}
