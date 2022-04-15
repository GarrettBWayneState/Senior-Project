//
//  SettingsVC.swift
//  TCM-XXI
//
//  Created by Garrett Berger on 9/25/21.
//  Copyright © 2021 LAGB. All rights reserved.
//
import UIKit


class SettingsVC: UIViewController
{
    
    @IBOutlet weak var BluSignalLabel: UILabel!
    @IBOutlet weak var BluSignalSlider: UISlider!
    
    @IBOutlet weak var SecurityLabel: UILabel!
    @IBOutlet weak var SecruitySwitch: UISwitch!
    
    

    
    @IBOutlet weak var DevLabel: UILabel!
    
    
    @IBOutlet weak var UpdateTimeLabel: UILabel!
    @IBOutlet weak var UpdateTimeButton: UIButton!
    
    

    @IBOutlet weak var ToMailData: UIButton!
    
    

        //performSegue(withIdentifier: "ToMailDataVC", sender: self)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
    
    @IBAction func ToMailDataButton(_ sender: Any)
    {
        performSegue(withIdentifier: "totestDataVC", sender: self)
    }
    // MARK: - Navigation
    

}
