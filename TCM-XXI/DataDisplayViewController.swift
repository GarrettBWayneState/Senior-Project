//
//  DataDisplayViewController.swift
//  TCM-XXI
//
//  Created by Garrett Berger on 9/30/21.
//  Copyright © 2021 LAGB. All rights reserved.
//
import UIKit

class DataDisplayViewController: UIViewController
{

    @IBOutlet weak var TitleVC: UILabel!


    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var hr: UILabel!
    @IBOutlet weak var minute: UILabel!
    
    
    @IBOutlet weak var lux: UILabel!
    @IBOutlet weak var mailval: UILabel!
    @IBOutlet weak var soc: UILabel!
    

    let bluSet = BluetoothSetup()//(DeviceName: "TCM", ServiceString: "11", TxString: "12", RxString: "12")
    //let mailData = BluetoothDevice(DeviceName: "TCM", ServiceString: "11", TxString: "12", RxString: "12")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "red screen"
        // Do any additional setup after loading the view.
        
        month.text = bluSet.blu.monthArrived
        day.text = bluSet.blu.dayArrived
        hr.text = bluSet.blu.hourArrived
        minute.text = bluSet.blu.minArrived
        
        mailval.text = bluSet.blu.mailArrived
        lux.text = bluSet.blu.luxValue
        soc.text = bluSet.blu.bluStatus
    }


}
