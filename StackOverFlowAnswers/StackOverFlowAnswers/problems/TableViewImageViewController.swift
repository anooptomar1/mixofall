//
//  TableViewImageViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/7/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TableViewImageViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func downloadImageAsync(url: String, completionHandler: (img: UIImage) -> Void){
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { () -> Void in
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if error == nil{
                    let im = UIImage(data: data!)
                    completionHandler(img: im!)
                }
            }
            task.resume()
        }
    }


}
extension TableViewImageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        let m = self.modalUrls[indexPath.row]
        cell!.textLabel!.text = m.title!
        
        downloadImageAsync(m.picUrl!) { (img) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell!.imageView!.image = img
                cell!.imageView!.layer.masksToBounds = true
                cell!.imageView!.clipsToBounds = true
                cell!.imageView!.layer.cornerRadius = 14.0
                cell!.setNeedsLayout()
            })
        }
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modalUrls.count
    }
}