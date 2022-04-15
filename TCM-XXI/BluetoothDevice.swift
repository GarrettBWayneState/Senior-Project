//
//  BluetoothDevice.swift
//  TCM-XXI
//
//  Created by Garrett Berger on 9/25/21.
//  Copyright © 2021 LAGB. All rights reserved.
//
import Foundation
import CoreBluetooth

class BluetoothDevice : NSObject
{
    // Variables

    var deviceName = String()       //     var name = ""

    var bluData = [String]()        //     var data : [String] = []
    var bluStatus = String()        //     var status = ""
    var mailArrived = String()
    var luxValue = String()
    var monthArrived = String()
    var dayArrived = String()
    var hourArrived = String()
    var minArrived = String()
    var yearArrived = String()
    var gotData = false
    
    
    var dates = [String]()
    var times = [String]()

    // Bluetooth Variables

    var service : CBService! = nil          //      var service : CBService! = nil
    var uuidService = CBUUID()              //      var serviceUUID = CBUUID()

    var txChar : CBCharacteristic! = nil    //      var tx : CBCharacteristic! = nil
    var uuidTx = CBUUID()                   //      var txUUID = CBUUID()

    var rxChar : CBCharacteristic! = nil    //      var rx : CBCharacteristic! = nil
    var uuidRx = CBUUID()                   //      var rxUUID = CBUUID()

    var central : CBCentralManager!         //      var central : CBCentralManager!
    var peripheral : CBPeripheral!          //      var peripheral : CBPeripheral!
    
    init(DeviceName : String, ServiceString : String, TxString : String, RxString : String)
    {
        super.init()
        
        self.deviceName = DeviceName
        
        self.uuidService = CBUUID(string: ServiceString)
        self.uuidTx = CBUUID(string: TxString)
        self.uuidRx = CBUUID(string: RxString)
    }
}
