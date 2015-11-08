//
//  AuthManager.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/3/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import Foundation
import OAuthSwift

let kDropboxAuthToken = "drop_box_token"

class AuthManager{
    
    // OAuth config information
    private let consumerKey = "<<consumer key>>"
    private let consumerSecret = "<<consumer secret>>"
    private let authUrl = "https://www.dropbox.com/1/oauth2/authorize"
    private let tokenUrl = "https://api.dropbox.com/1/oauth2/token"
    private let requestType = "token"
    // callback url (one that's authorized in dropbox api console)
    private let cbUrl = "devtechie://podplayer.com"
    
    // store authToken on local var for now
    private var auth_token: String?
    private var auth_token_secret: String?
    
    
    
    // create singleton using var computed property
    class var sharedInstance: AuthManager{
        // define a struct
        struct Static{
            // create static constant inside struct
            static let instance: AuthManager = AuthManager()
        }
        
        // return static instance
        return Static.instance
    }
    
    // http://stackoverflow.com/questions/26892108/ios8-swift-create-a-true-singleton-class
    
    // prevent class from being instantiated other than singleton
    private init(){}
    
    func initAuth(){
        // get the auth token
        authTokenFromDropbox()
    }
    
    // get auth
    private func authTokenFromDropbox(){
        // setting OAuth config
        let auth = OAuth2Swift(consumerKey: consumerKey, consumerSecret: consumerSecret, authorizeUrl: authUrl, accessTokenUrl: tokenUrl, responseType: requestType)
        // retrive token from callback
        auth.authorizeWithCallbackURL(NSURL(string: cbUrl)!, scope: "", state: "", success: { (credential, response, parameters) -> Void in
            self.auth_token = credential.oauth_token
            self.auth_token_secret = credential.oauth_token_secret
            // ------- uncomment below to save token into the user defaults
            //self.saveToken(credential.oauth_token)
            }) { (error: NSError) -> Void in
                print("Error: \(error.localizedDescription)")
        }
        
        
    }
    
    // function to save auth token into NSUserdefaults
    // change this to store auth to keychain
    private func saveToken(authToken: String){
        NSUserDefaults.standardUserDefaults().setObject(authToken, forKey: kDropboxAuthToken)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    // get user folders with completion handler
    func getUsersFolder(path: String?, completionHandler:((folderList: AnyObject?, error: NSError?) -> Void)?){
        // check if completion handler is nil return
        guard let completion = completionHandler else {
            return
        }
        
        // check if token doesn't exist return
        guard let token = auth_token else{
            return
        }
        
        // create nsmutable request to add auth header
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.dropboxapi.com/2-beta-2/files/list_folder")!)
        // set OAuth2.0 auth token
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        // set request header
        request.HTTPMethod = "POST"
        // request content type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // data to send over in post request body
        let dataToSend = ["path": (path ?? "")]
        
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(dataToSend, options: NSJSONWritingOptions.PrettyPrinted)
        }catch let err{
            print(err)
        }
        // create session so can be invalidated after its finished
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        // create url session
        let task = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            //print(response)
            if error == nil{
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                    completion(folderList: json, error: nil)
                }catch let err{
                    print(err)
                }
            }else{
                completion(folderList: nil, error: error!)
            }
            session.finishTasksAndInvalidate()
        }
        // call url session
        task.resume()
    }
    
    
    // get user details with completion handler to pass back the info from dropbox api
    func getUserDetails(completionHandler: ((userDetails: AnyObject?, error: NSError?) -> Void)?){
        if completionHandler != nil{
            if let token = auth_token{
                
                // create url request
                let request = NSMutableURLRequest(URL: NSURL(string: "https://api.dropboxapi.com/2/users/get_current_account")!)
                // auth header on request
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                // set content type
                //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // set http request method
                request.HTTPMethod = "POST"
                
                //NSURLSessionConfiguration object
                let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: config)
                let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, request: NSURLResponse?, error: NSError?) -> Void in
                    if error == nil{
                        do{
                            let jsonDictionary: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                            // call completionhandler
                            completionHandler!(userDetails: jsonDictionary, error: nil)
                        }catch let myError{
                            print(myError)
                        }
                    }else{
                        completionHandler!(userDetails:nil,error:  error)
                    }
                    session.finishTasksAndInvalidate()
                })
                task.resume()

            }
        }
    }
}




