//
//  URLSessionTestViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/3/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class URLSessionTestViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageInBackAndPopulate()
    }
    
    func loadImageInBackAndPopulate(){
        let urlString = "http://upload.wikimedia.org/wikipedia/commons/1/16/The_Shuttle_Enterprise_-_GPN-2000-001363.jpg"
        let url = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        // download task with NSURLSeesion. This will download the resource locally on the device and pass on the local url pointer back in completion handler
        let task = session.downloadTaskWithURL(url) { (location: NSURL?, response: NSURLResponse?, error:NSError?) -> Void in
            // check if error is not nil print the error and return
            guard error == nil else{
                print("Error \(error!)")
                return
            }
            // check for status code if its not 200 then return
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode == 200 else{
                return
            }
           
            // create image from NSData saved in local location after download is complete
            let image = UIImage(data: NSData(contentsOfURL: location!)!)
            // get main thread to assign image to imageview because download task happens on a background thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageview.image = image
            })
            session.finishTasksAndInvalidate()
        }
        task.resume()
    }
}
