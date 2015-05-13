//
//  DirDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/11/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class DirDemoViewController: UIViewController {

    var fileManager: NSFileManager!
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fileManager = NSFileManager.defaultManager()
        listContentOfDirectory()
        //deleteADirectory()
        //createNewFolderInTempDirectory()
        //getCurrentDirectoryPath()
        //getDocumentsDirPath()
        //getTempDirectory()
        //changePathToDocumentsDirectory()
    }
    
    func listContentOfDirectory(){
        var error: NSError?
        let fileList = fileManager.contentsOfDirectoryAtPath("/", error: &error)
        var content = " "
        for file in fileList!{
            content += "| \(file as! String) |"
        }
        label.text = content
    }
    
    func deleteADirectory(){
        let dirPath = NSTemporaryDirectory() as String
        let newDir = dirPath.stringByAppendingPathComponent("temp_data")
        var error: NSError?
        
        if !fileManager.removeItemAtPath(newDir, error: &error){
            label.text = "Failed: \(error!.localizedDescription)"
        }else{
            label.text = "Deleted"
        }
    }
    
    // create folder in temp directory
    func createNewFolderInTempDirectory(){
        let dirPath = NSTemporaryDirectory() as String
        let newDir = dirPath.stringByAppendingPathComponent("temp_data")
        var error: NSError?
        
        if !fileManager.createDirectoryAtPath(newDir, withIntermediateDirectories: true, attributes: nil, error: &error){
            label.text = "Failed: \(error!.localizedDescription)"
        }
        else{
            fileManager.changeCurrentDirectoryPath(newDir)
            self.label.text = fileManager.currentDirectoryPath
        }
        
    }
    
    // get path for current directory
    func getCurrentDirectoryPath(){
        label.text = fileManager.currentDirectoryPath
    }
    
    // get path for documents directory
    func getDocumentsDirPath(){
        label.text = ((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true))[0] as! String)
    }
    
    // get path of temp directory
    func getTempDirectory(){
        label.text = NSTemporaryDirectory() as String
    }
    
    // change directory
    func changePathToDocumentsDirectory(){
        let dirPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true))
        if fileManager.changeCurrentDirectoryPath((dirPath[0] as? String)!){
            label.text = fileManager.currentDirectoryPath
        }else{
            label.text = "Access denied! :("
        }
    }
    
}
