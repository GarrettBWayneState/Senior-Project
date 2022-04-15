//
//  MailDataVC.swift
//  TCM-XXI
//
//  Created by Server on 9/29/21.
//  Copyright © 2021 LAGB. All rights reserved.
//

import UIKit

class MailDataVC: UIViewController
{

    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var backButtonClicked: UIButton!

    
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var hr: UILabel!
    @IBOutlet weak var minute: UILabel!
    
    @IBOutlet weak var mail: UILabel!
    
    @IBOutlet weak var lux: UILabel!
    @IBOutlet weak var soc: UILabel!
    
    let bluSet = BluetoothSetup()//(DeviceName: "TCM", ServiceString: "11", TxString: "12", RxString: "12")
    let mailData = BluetoothDevice(DeviceName: "TCM", ServiceString: "11", TxString: "12", RxString: "12")
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        month.text = bluSet.blu.monthArrived
        day.text = bluSet.blu.dayArrived
        hr.text = bluSet.blu.hourArrived
        minute.text = bluSet.blu.minArrived
        
        mail.text = bluSet.blu.mailArrived
        lux.text = bluSet.blu.luxValue
        soc.text = bluSet.blu.bluStatus
    }
    
    @IBAction func backSettingsButton(_ sender: Any)
    {
        //performSegue(withIdentifier: "backToSettingsVC", sender: Any?.self)
    }
}
