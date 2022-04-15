//
//  MainVC.swift
//  TCM-XXI
//
//  Created by Garrett Berger on 9/25/21.
//  Copyright © 2021 LAGB. All rights reserved.
//
import UIKit
import CoreBluetooth
import Foundation

var dateStorage : [String] = []
var timeStorage : [String] = []
var arrivedStorage : [Bool] = []

@available(iOS 13.0, *)
class MainVC: UIViewController
{
    //@IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var MainButton: UIButton!
    
    let bSetup = BluetoothSetup()
    let hSetup = HistoryVC()
    let myTable = MyCustomTableViewCell()

    var work = [String]()        //     var data : [String] = []
    var statusTimer = Timer()
    

    // MARK: View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        statusTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateStatus), userInfo: nil, repeats: true)
        MainLabel.text = bSetup.blu.bluStatus
        MainLabel.textColor = .black
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func GoodGood(_ sender: Any?)
    {
        
       // if bSetup.blu.gotData == false
     //   {
            updateStatus()
            loadData()
            updateButtonLabel()
            connection()

            print("Testing new connection...\n")
            sleep(UInt32(3.0))                                  // sleep - wait after button clicked before starting new test
       // }
    }
    
 
    @objc func updateStatus()
    {
        let device = bSetup.blu
        let status = device.bluStatus
        
        self.MainLabel.text = bSetup.blu.bluStatus
        
        if status == "RX Char Found!"
        {
            bSetup.sendInquiries()
            loadData()
            updateButtonLabel()
        }
        if status == "Recieved Data"
        {
            bSetup.sendInquiries()
            loadData()
            updateButtonLabel()
        }
        if status == "Data Updated"
        {
            bSetup.sendInquiries()
            loadData()
            updateButtonLabel()
        }
    }
    
    func loadData()
    {
        print("\nLoading Data...")
    
        let device = bSetup.blu
        
        if device.bluData.count == 6                                                                                     // always execute the if statement NOT else
        {
            self.MainLabel.text = bSetup.blu.bluStatus
        
            
            formatData(device: device)                                                      // format func HERE
            
            
            self.bSetup.blu.mailArrived = device.bluData[0]
            self.bSetup.blu.minArrived = device.bluData[5]
            self.bSetup.blu.hourArrived = device.bluData[4]
            self.bSetup.blu.dayArrived = device.bluData[3]
            self.bSetup.blu.monthArrived = device.bluData[2]
            
            
            storeDateTime()                                                                 // Store Data func HERE
            updateUI()                                                                      // UpdateUI func HERE
        
        }
        else
        {
            self.MainLabel.text = bSetup.blu.bluStatus
            
            self.bSetup.blu.mailArrived = ""
            self.bSetup.blu.luxValue = ""
            self.bSetup.blu.monthArrived = ""
            self.bSetup.blu.hourArrived = ""
        }
        
        print("DATA from previous test...PRINTING:")
        print(bSetup.blu.bluData)
     
        // Testing array elements
        //print(bSetup.blu.bluData[0])
        //print(bSetup.blu.bluData[1])
        
        addDataAfterButtonTap()                                                         // ADD Data after history tapped func HERE

        device.bluData.removeAll()          // remove data elements
        print("Data Removed Suceesfully!")
    }
    
    func formatData(device : BluetoothDevice)
    {
        if device.bluData[0] == "1"
        {
           //device.bluData[0] = "Your Mail Has Arrived!"
            performSegue(withIdentifier: "toMailArrived", sender: self)
           // print(device.bluData[0])
        }
        else
        {
            //device.bluData[0] = "No Mail Yet!"
            performSegue(withIdentifier: "toMailNotArrived", sender: self)
        }
        if device.bluData[1].count == 1
        {
            //device.bluData[1] = "Your LUX (if)"
            device.bluData[1].insert("0", at: device.bluData[1].startIndex)
        }
        else
        {
            //device.bluData[1] = "Your LUX (else)"
        }
        if device.bluData[2].count == 1
        {
            //device.bluData[2] = "Your Min (if)"
            device.bluData[2].insert("0", at: device.bluData[2].startIndex)
        }
        else
        {
            //device.bluData[2] = "Your Min (else)"
        }
        if device.bluData[3].count == 3
        {
            //  device.bluData[3] = "Your Hour (if)"
            device.bluData[3].insert("0", at: device.bluData[3].startIndex)
        }
        else
        {
            //device.bluData[3] = "Your Hour (else)"
        }
        if device.bluData[4].count == 4
        {
            //device.bluData[4] = "Your Day (if)"
            device.bluData[4].insert("0", at: device.bluData[4].startIndex)
        }
        else
        {
            //device.bluData[4] = "Your Day (else)"
        }
        if device.bluData[5].count == 5
        {
            //device.bluData[5] = "Your Month (if)"
            device.bluData[5].insert("0", at: device.bluData[5].startIndex)
        }
        else
        {
            // device.bluData[5] = "Your Month (else)"
        }
        // Testing - Currently, (else) is printed evertime it was a correct format of time.
        // Testing - Currently, (if) is printed evertime then it was a wrong format of time. Usually cause by minute being the third element after lux. This might be because minute and month are both double digits.
    }
    
    @objc func connection()
    {
        let device = bSetup.blu
        
        if device.peripheral.state == .connected
        {
            device.central.cancelPeripheralConnection(device.peripheral)
        }
        else
        {
            bSetup.blu.central = CBCentralManager(delegate: bSetup, queue: nil)
            bSetup.blu.central.delegate = bSetup
        }
    }
    
    func updateButtonLabel()
    {
        let device = bSetup.blu
        
        if device.peripheral?.state == .connected
        {
            self.MainButton.setTitle("Disconnect", for: .normal)
        }
        else
        {
            self.MainButton.setTitle("Connect", for: .normal)
        }
    }
    
    func storeDateTime()
    {
        let device = bSetup.blu
        
        let month = device.bluData[2]
        let day = device.bluData[3]
        let hour = device.bluData[4]
        let min = device.bluData[5]
        
        if month != "00" && day != "00" && hour != "00" && min != "00"
        {
            let date = device.bluData[2] + "/" + device.bluData[3]
            let time = device.bluData[4] + ":" + device.bluData[5]

            dateStorage.append(date)
            timeStorage.append(time)
    
            device.central.cancelPeripheralConnection(device.peripheral)
            
            device.bluStatus = "Mail Arrived!"
            updateStatus()
        }
    }
    
    @objc func updateUI()
    {
            if bSetup.blu.monthArrived == "11"              // testing date format
            {
                // puts time after index 0
                //hSetup.dates.append(bSetup.blu.monthArrived + "/" + bSetup.blu.dayArrived)
               // hSetup.times.append(bSetup.blu.hourArrived + ":" + bSetup.blu.minArrived)
                
                // puts time at index 0
               // hSetup.dates.insert(bSetup.blu.monthArrived + "/" + bSetup.blu.dayArrived, at: 0)
               // hSetup.times.insert(bSetup.blu.hourArrived + ":" + bSetup.blu.minArrived, at: 0)

               // print(hSetup.dates)
               // print(hSetup.times)
                
                print("DATE FORMAT = CORRECT\n")
            }
            else
            {
                print("DATE FORMAT = INCORRECT\n")
            }
    }
    
    @objc func addDataAfterButtonTap()
    {
        if MainButton.isEnabled == true
        {
            print("\nMain Button Tapped!")
            
            if bSetup.blu.mailArrived == "1"
            {
                arrivedStorage.append(true)
                print("Mail Arrived Statues = TRUE\n")
            }
            else if bSetup.blu.mailArrived == "0"
            {
                arrivedStorage.append(false)
                print("Mail Arrived Statues = FALSE\n")
            }
            else
            {
                print("ERRRROR")
            }
        }
        else
        {
            print("\nMain Button Not Tapped!")
        }
    }
    
    
}
