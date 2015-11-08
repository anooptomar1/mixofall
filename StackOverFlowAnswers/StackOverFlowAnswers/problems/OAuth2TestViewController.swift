//
//  OAuth2TestViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/1/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit
import OAuthSwift

class OAuth2TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAuth()
    }
    
    func initAuth(){
        AuthManager.sharedInstance.initAuth()
    }
    
    @IBAction func dismissButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func getUserInfoPressed(sender: UIButton) {
       getFolderDetails("/books")
        //getFolderDetails(nil)
    }
    
   
    func getFolderDetails(path: String?){
        AuthManager.sharedInstance.getUsersFolder(path) { (folderList, error) -> Void in
            if error == nil{
                print(folderList!)
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    func getUserDetails(){
        AuthManager.sharedInstance.getUserDetails { (userDetails, error) -> Void in
            if error == nil{
                print(userDetails!)
            }else{
                print(error!.localizedDescription)
            }
        }
    }
}
