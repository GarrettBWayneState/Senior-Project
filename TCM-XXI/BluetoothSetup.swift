//
//  BluetoothSetup.swift
//  TCM-XXI
//
//  Created by Garrett Berger on 9/25/21.
//  Copyright © 2021 LAGB. All rights reserved.
//
import Foundation
import CoreBluetooth

class BluetoothSetup: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate
{
    
    let blu = BluetoothDevice(DeviceName: "My Senior Project", ServiceString: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E", TxString: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E", RxString: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
    
    /*!
     *  @method centralManagerDidUpdateState:
     *
     *  @param central  The central manager whose state has changed.
     *
     *  @discussion     Invoked whenever the central manager's state has been updated. Commands should only be issued when the state is
     *                  <code>CBCentralManagerStatePoweredOn</code>. A state below <code>CBCentralManagerStatePoweredOn</code>
     *                  implies that scanning has stopped and any connected peripherals have been disconnected. If the state moves below
     *                  <code>CBCentralManagerStatePoweredOff</code>, all <code>CBPeripheral</code> objects obtained from this central
     *                  manager become invalid and must be retrieved or discovered again.
     *
     *  @see            state
     *
     */
    
    override init()
    {
        super.init()
        self.blu.bluStatus = "Press Button To Begin"

        blu.central?.delegate = self
        self.blu.central = CBCentralManager(delegate: self, queue: nil)
        
       // self.blu.bluData = self.bluBegin()
    }
    
    @available(iOS 5.0, *)
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        let serviceArray = [self.blu.uuidService]
       
        switch central.state
        {
        case .poweredOn:
            blu.bluStatus = "Scanning For Peripherals..."
            print("Bluetooth On")
           
            central.scanForPeripherals(withServices: serviceArray, options: nil)
            print("Scanning For Peripherals...")
           
        case .poweredOff:
            blu.bluStatus = "Please Turn On Bluetooth"
            print("* Bluetooth Powered Off *")
           
        default:
            blu.bluStatus = "Bluetooth Error"
            print("* Bluetooth Could Not Be Powered On *")
        }
    }
        
        func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
        {
            
            blu.bluStatus = "Discovered Peripheral"
            print("Attempting To Connect...")
            
            if peripheral.name == blu.deviceName
            {
                blu.bluStatus = "Found Device"
                print("Found Device")
                blu.central.stopScan()
                blu.peripheral = peripheral
                blu.peripheral.delegate = self
                
                blu.central.connect(peripheral, options: nil)
            }
        }
        
        func centralManager(_ central: CBCentralManager, didConnect peripheralRef: CBPeripheral)
        {
            blu.bluStatus = "Peripheral Connected!"
            print("Peripheral Connected!")
            
            blu.peripheral.discoverServices(nil)
        }
        
        func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?)
        {
            blu.bluStatus = "* Connection Failed *"
            print("* Connection Failed *")
        }
        
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
        {
            if let mainService = blu.peripheral.services?[0] // If Services Are Available & Valid
            {
                blu.service = mainService // Defining Device Service
                blu.bluStatus = "Service Found"
                print("Service Found")
                
                blu.peripheral.discoverCharacteristics(nil, for: blu.service)
            }
            else
            {
                print("* No Services Discovered *")
            }
        }
        
        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
        {
            if let characteristics = blu.service.characteristics
            {
                for char in characteristics
                {
                    if char.uuid == blu.uuidTx
                    {
                        blu.txChar = char
                        
                        blu.bluStatus = "TX Char Found!"
                        print("TX Char Found!")
                    }
                        
                    else if char.uuid == blu.uuidRx
                    {
                        blu.rxChar = char
                        
                        blu.bluStatus = "RX Char Found!"
                        print("RX Char Found!")
                        
                        blu.peripheral.setNotifyValue(true, for: blu.rxChar)
                    }
                }
                
                sendInquiries()
            }
            else
            {
                print("error - didDiscoverCharacterisiticsForService")
                blu.peripheral.discoverServices(nil)
            }
        }

        func sendInquiries()
        {
            let inquiries = [0, 1, 2, 3, 4, 5]
            
            blu.bluStatus = "Sending Inquiry..."
            print("Sending Inquiry...")
            
            for inq in inquiries            
            {
                let inqString = String(inquiries[inq])
                
                if let inqData = inqString.data(using: .utf8)
                {
                    blu.peripheral.writeValue(inqData, for: blu.txChar, type: .withoutResponse)         // print array elements here
                }
            }
        }
    
        func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
        {
            
            blu.bluStatus = "Value Updated"
            print("Value Updated")
            
            if let strValue = String(bytes: blu.rxChar.value!, encoding: String.Encoding.utf8)
            {
                blu.bluData.append(strValue)
                print(strValue)
                print(blu.bluData)
            }
            else
            {
                blu.bluStatus = "Fatal Error: Unwrapping strValue"
                print("Fatal Error: Unwrapping strValue")
            }
            if blu.bluData.count == 6
            {
                blu.bluStatus = "Recieved All Data From Device"
                print("Recieved All Data From Device")
                if let peripheral = blu.peripheral
                {
                    blu.central.cancelPeripheralConnection(peripheral)
                }
                else
                {
                    print("Didn't Recieved All Data")
                }
            }
            if blu.bluData[0] == "1"
            {
                //print("Your Mail Has Arrived!")
            }
            else if blu.bluData[0] == "0"
            {
                //print("Your Mail Has Not Arrived!")
            }
            else
            {
                print("ERROR")
            }
          //  print("Testing location on run up")
        }
        
        func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)
        {
            blu.bluStatus = "Peripheral Disconnected"
            print("* Peripheral Disconnected *")
        }
      // return blu.bluData
    //}
}

