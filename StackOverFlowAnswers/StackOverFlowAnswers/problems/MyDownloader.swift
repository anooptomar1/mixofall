//
//  MyDownloader.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/5/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import Foundation
class MyDownloader: NSObject {
    // typealias for completion handler
    typealias myCompletionHandler = (NSURL?)->Void
    //  private member variable for NSURLSessionConfiguration
    private var config: NSURLSessionConfiguration!
    // NSURLSession lazy property to handle shared sessions with one init
    private lazy var session: NSURLSession = {
        let session = NSURLSession(configuration: self.config, delegate: self, delegateQueue: NSOperationQueue())
        return session
    }()
    init(config: NSURLSessionConfiguration) {
        self.config = config
        super.init()
    }
    
    func download(urlString: String, completionHandler: myCompletionHandler) -> NSURLSessionTask?{
        // check if urlString is not empty
        guard urlString.characters.count > 0 else{
            return nil
        }
        // create NSURL from urlString
        let url = NSURL(string: urlString)!
        // create NSMutableURLRequest for url string
        let request = NSMutableURLRequest(URL: url)
        // there can be multiple download going on at the same time so we don't know which completion handler to call so using NSURLProtocol we can store completion handler with each request
        // now since NSURLProtocol takes any object and returns anyobject we will create a wrapper class to unwrap it later
        NSURLProtocol.setProperty(Wrapper(completionHandler), forKey: "ch", inRequest: request)
        // create downloadtask with request and return task to user for cancellation if needed
        let task = self.session.downloadTaskWithRequest(request)
        task.resume()
        return task
    }
    
    func cancelAllTasks(){
        // this will be called at deinit of caller or anywhere else to make sure that NSURLSession doesn't hold any retain cycle
        self.session.invalidateAndCancel()
    }
    deinit{
        self.session.invalidateAndCancel()
    }
}
extension MyDownloader: NSURLSessionDownloadDelegate{
    @objc func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        // get original request to retrive completion handler from it
        let request = downloadTask.originalRequest
        // get completion handler from NSURLProtocol of original request
        let ch: AnyObject = NSURLProtocol.propertyForKey("ch", inRequest: request!)!
        let response = downloadTask.response as! NSHTTPURLResponse
        let stat = response.statusCode
        var url: NSURL! = nil
        if stat == 200{
            url = location
        }
        // unwrap as completion handler and call completion handler
        let ch2 = (ch as! Wrapper).p as myCompletionHandler
        ch2(url)
        session.finishTasksAndInvalidate()
    }
    
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        session.invalidateAndCancel()
    }
}

class Wrapper<T>{
    let p: T
    init(_ p: T){
        self.p = p
    }
}