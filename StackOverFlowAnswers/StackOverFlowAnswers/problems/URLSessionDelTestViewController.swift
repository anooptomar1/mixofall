//
//  URLSessionDelTestViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/5/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class URLSessionDelTestViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var task: NSURLSessionTask!
    // lazy definition for NSURLSession
    lazy var session: NSURLSession = {
        // create configuration with no caching config
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        // disable download on cellular network connection type
        config.allowsCellularAccess = false
        // create session with configuration on NSOperationQueue background thread
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue())
        // return newly created session
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageFromInternet()
        // remove thumb from slider control
        slider.setThumbImage(UIImage(), forState: UIControlState.Normal)
    }

    func loadImageFromInternet(){
        // create NSURL object for image url
        let url = NSURL(string: "http://upload.wikimedia.org/wikipedia/commons/1/16/The_Shuttle_Enterprise_-_GPN-2000-001363.jpg")!
        // create nsmutablerequest
        let req = NSMutableURLRequest(URL: url)
        // create download task with request
        let task = self.session.downloadTaskWithRequest(req)
        // assign download task to global variable so can be cancelled or freed up later
        self.task = task
        // call task.resume to start the download
        task.resume()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // NSURLSesion delegate is not a weak delegate in the class its a strong property so it will retain the reference
        // because NSURLSession keeps a retain cycle on self we will have to make sure that finish and invalidate gets called on view will disappear. This can't be put in deinit function because due to the retain cycle deinit will never be called
        self.session.finishTasksAndInvalidate()
    }

}


extension URLSessionDelTestViewController: NSURLSessionDownloadDelegate{
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // because downloading is going on on background thread access main thred
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            // update slider with total bytes received percentage
            self.slider.setValue(Float(100 * totalBytesWritten / totalBytesExpectedToWrite), animated: true)
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        // if there was an error occured error object will not be nil
        guard error == nil else{
            // print error details
            print("Downloading Error: \(error!.localizedDescription)")
            // cancel current running task
            self.task.cancel()
            // set task to nil
            self.task = nil
            // return from here
            return
        }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        // finished downloading then set task to nil
        self.task = nil
        // collect response to check the response code
        let response = downloadTask.response as! NSHTTPURLResponse
        // if response code is not 200 then return
        guard response.statusCode == 200 else{
            print(response.statusCode)
            return
        }
        // get content into NSData from the local url of downloaded resource
        let d = NSData(contentsOfURL: location)
        // create UIImage from data received
        let im = UIImage(data: d!)
        // call main thread to update imageview with received image
        dispatch_async(dispatch_get_main_queue()){
            self.imageView.image = im
        }
    }
}