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
        
        truncateAFile()
        //writeAFile()
        //openAFile()
        //removeFolder()
        //copyFile()
        //moveFile()
        //isFileReadableWritable()
        //compareFileContents()
        //removeAllAtPath()
        //createFileAtPath()
        //checkPresenceOfAFile()
        //getFileAttribute()
        //listContentOfDirectory()
        //deleteADirectory()
        //createNewFolderInTempDirectory()
        //getCurrentDirectoryPath()
        //getDocumentsDirPath()
        //getTempDirectory()
        //changePathToDocumentsDirectory()
    }
    
    // truncate a file
    func truncateAFile(){
        let dirPath = NSTemporaryDirectory() as String
        let filePath = dirPath.stringByAppendingPathComponent("dataFile2.data")
        let file = NSFileHandle(forUpdatingAtPath: filePath)
        
        if file == nil{
            label.text = "Couldn't open the file"
        }else{
            file?.truncateFileAtOffset(5)
            file?.seekToFileOffset(0)
            var dataBuffer = file?.readDataToEndOfFile()
            file?.closeFile()
            label.text = NSString(data: dataBuffer!, encoding: NSUTF8StringEncoding) as? String
        }
    }
    
    
    // write data to a file NSFileHandle
    func writeAFile(){
        let dirPath = NSTemporaryDirectory() as String
        let filePath = dirPath.stringByAppendingPathComponent("dataFile2.data")
        let file = NSFileHandle(forUpdatingAtPath: filePath)
        if file == nil{
            label.text = "Sorry, couldn't open the file for you :("
        }else{
            label.text = "File is open. Now writing something new in it"
            let data = ("Who let the dogs out.. WHO WHO WHO").dataUsingEncoding(NSUTF8StringEncoding)
            file?.seekToEndOfFile()
            file?.writeData(data!)
            file?.closeFile()
        }
    }
    
    // open a file using NSFileHandle
    func openAFile(){
        let dirPath = NSTemporaryDirectory() as String
        let filePath = dirPath.stringByAppendingPathComponent("dataFile2.data")
        let file: NSFileHandle? = NSFileHandle(forReadingAtPath: filePath)
        if file == nil{
            label.text = "Error opening the file"
        }else{
            let dataBuffer = file?.readDataToEndOfFile()
            file?.closeFile()
            let stringData = NSString(data: dataBuffer!, encoding: NSUTF8StringEncoding) as? String
            label.text = stringData
        }
    }
    
    // remove folder
    func removeFolder(){
        let dir = NSTemporaryDirectory() as String
        let newFolder = dir.stringByAppendingPathComponent("new")
        var error: NSError?
        
        var content = ""
        if fileManager.removeItemAtPath(newFolder, error: &error){
            content = "Removed folder"
        }else{
            content = "Failed remove"
        }
        
        let fileList = fileManager.contentsOfDirectoryAtPath(dir, error: nil)
        if let items = fileList{
            
            for item in items{
                content += item as! String
            }
        }
        label.text = content
    }
    
    // copy file from one folder to other
    func copyFile(){
        let dir = NSTemporaryDirectory() as String
        let newFolder = dir.stringByAppendingPathComponent("new")
        var error: NSError?
        if fileManager.copyItemAtPath(newFolder.stringByAppendingPathComponent("dataFile2.data"), toPath: dir.stringByAppendingPathComponent("dataFile2.data"), error: &error){
            label.text = "File Copied"
        }else{
            label.text = "Copy failed"
        }
    }
    
    // create a new folder in temp directory and move a file inside
    func moveFile(){
        let dir = NSTemporaryDirectory() as String
        let newFolder = dir.stringByAppendingPathComponent("new")
        var error: NSError?
        if !(fileManager.createDirectoryAtPath(newFolder,
            withIntermediateDirectories: true, attributes: nil, error: &error)){
            label.text = "Folder creation failed!"
        }else{
            let file = dir.stringByAppendingPathComponent("dataFile2.data")
            if fileManager.moveItemAtPath(file, toPath: newFolder.stringByAppendingPathComponent("dataFile2.data"), error: &error){
                label.text = "Moved Successfully"
            }else{
                label.text = "Move failed"
            }
        }
        
    }
    
    // check if file is writable and readable at path
    func isFileReadableWritable(){
        let file = (NSTemporaryDirectory() as String).stringByAppendingPathComponent("dataFile.dat")
        var content = ""
        if fileManager.isReadableFileAtPath(file){
            content = "Yeah its readable"
        }else{
            content += "Sorry not readable"
        }
        if fileManager.isWritableFileAtPath(file){
            content += "\nYeah its writable"
        }else{
            content += "Sorry not writable"
        }
        label.text = content
    }
    
    // comparing file contents
    func compareFileContents(){
        var file1 = (NSTemporaryDirectory() as String).stringByAppendingPathComponent("dataFile.dat")
        var file2 = (NSTemporaryDirectory() as String).stringByAppendingPathComponent("dataFile2.data")
        if fileManager.contentsEqualAtPath(file1, andPath: file2){
            label.text = "Contents are exact same"
        }else{
            label.text = "Not same"
        }
    }
    
    // remove file at path
    func removeAllAtPath(){
        var tempDir = NSTemporaryDirectory() as String
        let fileList = fileManager.contentsOfDirectoryAtPath(tempDir, error: nil)
        var content = ""
        for file in fileList!{
            let fileAttr = fileManager.attributesOfItemAtPath(tempDir.stringByAppendingPathComponent(file as! String), error: nil)
            if let atr = fileAttr{
                if atr["NSFileType"] as! String == "NSFileTypeRegular"{
//                    if fileManager.removeItemAtPath(tempDir.stringByAppendingPathComponent(file as! String), error: nil){
//                        content = "Files removed"
//                    }else{
//                        content = "Not removed :("
//                    }
                    content += "| \(file as! String) |"
                }
            }
        }
        label.text = content
    }
    
    // create file at path
    func createFileAtPath(){
        var tempDir = NSTemporaryDirectory() as String
        var dataFile = tempDir.stringByAppendingPathComponent("dataFile.dat")
        var dataFile2 = tempDir.stringByAppendingPathComponent("dataFile2.data")
        var dataBuffer = ("some data").dataUsingEncoding(NSUTF8StringEncoding)
        fileManager.createFileAtPath(dataFile, contents: dataBuffer, attributes: nil)
        fileManager.createFileAtPath(dataFile2, contents: dataBuffer, attributes: nil)
        if fileManager.fileExistsAtPath(dataFile){
            label.text = "File Exists"
        }else{
            label.text = "File doesn't exists"
        }
    }
    
    // check the presence of the file
    func checkPresenceOfAFile(){
        if fileManager.fileExistsAtPath("/Applications"){
            label.text = "It Exists  ;)"
        }else{
            label.text = "File not found"
        }
    }
    
    // check file attribute of a file or folder of a path
    func getFileAttribute(){
        let dirPath = NSTemporaryDirectory() as String
        
        if fileManager.changeCurrentDirectoryPath(dirPath){
            let filelist = fileManager.contentsOfDirectoryAtPath(fileManager.currentDirectoryPath, error: nil)
            println(fileManager.currentDirectoryPath)
            var content = " "
            for file in filelist!{
                let attribs: NSDictionary? = fileManager.attributesOfItemAtPath(dirPath.stringByAppendingPathComponent(file as! String), error: nil)
                if let fileAttr = attribs{
                    let fileType = fileAttr["NSFileType"] as! String
                    let fileModified = fileAttr["NSFileModificationDate"] as! NSDate
                    content += "\(file as! String) is a \(fileType) and was modified on \(fileModified)"
                }
            }
            label.text = content
        }
        else{label.text = "Access Denied :("}
    }
    
    // list content of directory
    func listContentOfDirectory(){
        var error: NSError?
        let fileList = fileManager.contentsOfDirectoryAtPath("/", error: &error)
        var content = " "
        for file in fileList!{
            content += "| \(file as! String) |"
        }
        label.text = content
    }
    
    // delete directory at a give path
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
