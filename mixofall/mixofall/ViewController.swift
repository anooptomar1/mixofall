//
//  ViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 2/26/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate {

    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var goButton: UIBarButtonItem!
    @IBOutlet weak var webSection: UIWebView!
    @IBOutlet weak var shortButton: UIBarButtonItem!
    @IBOutlet weak var copyButton: UIBarButtonItem!
    
    var shortData: NSMutableData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webSection.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onGo(sender: UIBarButtonItem) {
        var request = NSURLRequest(URL: NSURL(string: loadUrl())!)
        webSection.loadRequest(request)
        urlText.resignFirstResponder()
    }
    
    func loadUrl() -> String{
        var url = urlText.text
        if(url.hasPrefix("http://") || url.hasPrefix("https://")){
            return url
        }else{
            return "http://\(url)"
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        println(error)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        urlText.text = webView.request?.URL!.absoluteURL?.absoluteString
        shortButton.enabled = true
    }

    @IBAction func onCopy(sender: UIBarButtonItem) {
        UIPasteboard.generalPasteboard().URL = NSURL(string: (shortButton.title)!)
    }
////
    @IBAction func onShortButton(sender: UIBarButtonItem) {
        var encodedUrl = webSection.request?.URL!.absoluteString?.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var tinyUrlString = "http://tinyurl.com/api-create.php?url=\(encodedUrl!)"
        
        let request = NSURLRequest(URL: NSURL(string: tinyUrlString)!)
        
        var urlConnection = NSURLConnection(request: request, delegate: self)
        shortButton.enabled = false
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        shortData = NSMutableData()
       shortData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        if let data = shortData{
            let shortString = NSString(data: data, encoding: NSUTF8StringEncoding)
            shortButton.title = shortString as? String
            copyButton.enabled = true
        }
    }
    
}

