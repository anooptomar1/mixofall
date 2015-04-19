//
//  BlueToothAViewController.swift
//  pageApp
//
//  Created by Anoop tomar on 4/11/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
//import CoreBluetooth
import ExternalAccessory
import CoreLocation

class BlueToothAViewController: UIViewController {

    @IBOutlet weak var outputText: UITextView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // core location
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        // end core location
        
        outputText.text! += "\n registering something connected"
        EAAccessoryManager.sharedAccessoryManager().registerForLocalNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "somethingConnected:", name: EAAccessoryDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "somethingDisconnected:", name: EAAccessoryDidDisconnectNotification, object: nil)
        //checkAllAccessory()
    }
    
    func somethingConnected(accessory: EAAccessory){
        //if accessory.protocolStrings.count > 0{
            outputText.text! += "\n something connected"
            outputText.text! += "\n \(accessory.description)"
        //}
    }
    
    func somethingDisconnected(accessory: EAAccessory){
        //if accessory.protocolStrings.count > 0{
            outputText.text! += "\n something disconnected"
            outputText.text! += "\n \(accessory.description)"
        //}
    }
    
    deinit{
        NSNotificationCenter.removeObserver(self, forKeyPath: EAAccessoryDidConnectNotification)
        NSNotificationCenter.removeObserver(self, forKeyPath: EAAccessoryDidDisconnectNotification)
        EAAccessoryManager.sharedAccessoryManager().unregisterForLocalNotifications()
    }
//    func checkAllAccessory(){
//        var accessories = EAAccessoryManager.sharedAccessoryManager().connectedAccessories
//        outputText.text! += "\n searching..."
//        for acc in accessories{
//            outputText.text! += "\n \(acc.description!)"
//            //acc.accessoryDidDisconnect(<#accessory: EAAccessory!#>)
//        }
//    }
}

extension BlueToothAViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue = manager.location.coordinate
        outputText.text! += "\n lat:\(locValue.latitude) lon: \(locValue.longitude) \n"
        manager.stopUpdatingLocation()
    }
}

// this will get all devices that are around as peripheral
//class BlueToothAViewController: UIViewController {
//
//    @IBOutlet weak var outputText: UITextView!
//    
//    var cbCentralManager: CBCentralManager!
//    var cbPeripheral: CBPeripheral!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        startUpCentralManager()
//        
//    }
//    
//    @IBAction func onClear(sender: UIButton) {
//        
//        outputText.text! = ""
//        
//    }
//    func startUpCentralManager(){
//        cbCentralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
//    }
//}
//
//extension BlueToothAViewController: CBCentralManagerDelegate{
//    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
//        self.cbPeripheral.delegate = self;
//        self.cbPeripheral.discoverServices(nil)
//        outputText.text! += "\nConnected"
//    }
//    
//    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
//        outputText.text! += "\nDiscovered \(peripheral.name)"
//        outputText.text! += "\nidentifier \(peripheral.identifier)"
//        outputText.text! += "\nservices \(peripheral.services)"
//        outputText.text! += "\nRSSI \(RSSI)"
//        
//        self.cbPeripheral = peripheral;
//        
//        central.connectPeripheral(self.cbPeripheral, options: nil)
//    }
//    
//    func centralManagerDidUpdateState(central: CBCentralManager!) {
//        switch(central.state){
//        case .PoweredOff:
//            outputText.text! += "\n Device Bluetooth is Powered Off"
//        case .PoweredOn:
//            outputText.text! += "\n Device Bluetooth is Powered On"
//            cbCentralManager.scanForPeripheralsWithServices(nil, options: nil)
//        case .Resetting:
//            outputText.text! += "\n Device Bluetooth is Resetting"
//        case .Unauthorized:
//            outputText.text! += "\n Device Bluetooth is Unauthorized"
//        case .Unknown:
//            outputText.text! += "\n Device Bluetooth is Unknown"
//        case .Unsupported:
//            outputText.text! += "\n Device Bluetooth is Unsupported"
//        }
//    }
//    
//    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
//        outputText.text! += "\nDisconnected"
//        
//        self.cbPeripheral = nil;
//        startUpCentralManager()
//
//    }
//}
//
//extension BlueToothAViewController: CBPeripheralDelegate{
//    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
//        
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
//        
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
//        
//    }
//}

//extension BlueToothAViewController: CBPeripheralDelegate{
//    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(service.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(characteristic.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didDiscoverIncludedServicesForService service: CBService!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(service.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didModifyServices invalidatedServices: [AnyObject]!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didReadRSSI RSSI: NSNumber!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(RSSI) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(characteristic.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(characteristic.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didUpdateValueForDescriptor descriptor: CBDescriptor!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(descriptor.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didWriteValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(characteristic.description) \n"
//    }
//    
//    func peripheral(peripheral: CBPeripheral!, didWriteValueForDescriptor descriptor: CBDescriptor!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//        outputText.text! += "\n \(descriptor.description) \n"
//    }
//    
//    func peripheralDidInvalidateServices(peripheral: CBPeripheral!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//    }
//    
//    func peripheralDidUpdateName(peripheral: CBPeripheral!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//    }
//    
//    func peripheralDidUpdateRSSI(peripheral: CBPeripheral!, error: NSError!) {
//        outputText.text! += "\n \(peripheral.description) \n"
//    }
//}


////// use this code to create peripheral service and broadcast

// class BlueToothAViewController: UIViewController {
//    let kServiceUUID = "5da441ce-73fd-4a38-993f-1714bce5f67e"
//    let kCharUUID = "93606493-fe00-4637-8098-22a711c12648"
//    
//    var service: CBMutableService!
//    var characteristic: CBMutableCharacteristic?
//    
//    var cbPeripheralMgr: CBPeripheralManager!
//    
//    @IBOutlet weak var outputText: UITextView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.cbPeripheralMgr = CBPeripheralManager(delegate: self, queue: nil, options: nil)
//    }
//    
//    func createService(){
//        outputText.text! += "\n starting to create service..."
//        var serviceUUID = CBUUID(string: kServiceUUID)
//        self.service = CBMutableService(type: serviceUUID, primary: true)
//        var charUUID = CBUUID(string: kCharUUID)
//        self.characteristic = CBMutableCharacteristic()
//        self.characteristic?.UUID = charUUID
//        self.characteristic?.permissions = CBAttributePermissions.Readable
//        self.characteristic?.properties = CBCharacteristicProperties.Notify
//        self.characteristic?.value = nil
//        
//        self.service.characteristics = [self.characteristic!]
//        self.cbPeripheralMgr.addService(self.service)
//        outputText.text! += "\n service created..."
//    }
//
//}
//
//extension BlueToothAViewController: CBPeripheralManagerDelegate{
//    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
//        outputText.text! += "\n inside peripheral delegate..."
//        if peripheral.state == CBPeripheralManagerState.PoweredOn{
//            outputText.text! += "\n peripheral powered on..."
//            createService()
//        }
//    }
//    
//    func peripheralManager(peripheral: CBPeripheralManager!, didAddService service: CBService!, error: NSError!) {
//        if error == nil{
//            outputText.text! += "\n starting to advertise..."
//            cbPeripheralMgr.startAdvertising([CBAdvertisementDataServiceUUIDsKey: service.UUID])
//            outputText.text! += "\n advertising..."
//        }else{
//            outputText.text! += "\n ---- Error BEGIN ---- \n"
//            outputText.text! += error.description
//            outputText.text! += "\n ---- Error END ---- \n"
//        }
//    }
//    
//    func peripheralManager(peripheral: CBPeripheralManager!, didReceiveReadRequest request: CBATTRequest!) {
//        outputText.text! += "\n ---- Received read request ---- \n"
//        outputText.text! += "\n \(request.description) \n"
//    }
//    
//    func peripheralManager(peripheral: CBPeripheralManager!, didReceiveWriteRequests requests: [AnyObject]!) {
//        outputText.text! += "\n ---- Received read request ---- \n"
//        for request in requests{
//            outputText.text! += "\n \(request.description) \n"
//        }
//    }
//    
//    
//    func peripheralManager(peripheral: CBPeripheralManager!, central: CBCentral!, didSubscribeToCharacteristic characteristic: CBCharacteristic!) {
//        outputText.text! += "\n inside Central... \n"
//        outputText.text! += central.description
//        outputText.text! += "\n"
//    }
//    
//}


////// Code below works when you want to make your phone as central and peripheral is advertising
//
//class BlueToothAViewController: UIViewController {
//
//    var cbManager: CBCentralManager!
//    
//    
//    @IBOutlet weak var outputText: UITextView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //cbManager.delegate = self
//        cbManager = CBCentralManager(delegate: self, queue: nil, options: nil)
////        if cbManager.state == CBCentralManagerState.PoweredOn{
////            cbManager.scanForPeripheralsWithServices(nil, options: nil)
////            outputText.text! += "Scanning..."
////        }
//    }
//
//}
//
//extension BlueToothAViewController: CBCentralManagerDelegate{
//    func centralManagerDidUpdateState(central: CBCentralManager!) {
//        if central.state == CBCentralManagerState.PoweredOn{
//            central.scanForPeripheralsWithServices(nil, options: nil)
//            outputText.text! += "Scanning..."
//        }
//    }
//    
//    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
//        outputText.text! += peripheral.description
//   }
//}

