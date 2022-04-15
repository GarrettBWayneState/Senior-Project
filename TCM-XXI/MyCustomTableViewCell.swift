//
//  MyCustomTableViewCell.swift
//  TCM-XXI
//
//  Created by Garrett Berger on 10/28/21.
//  Copyright © 2021 LAGB. All rights reserved.
//
import UIKit

@available(iOS 13.0, *)
class MyCustomTableViewCell: UITableViewCell
{

    static let identifier = "MyCustomTableViewCell"
    static let identifier2 = "MyCustomTableViewCell2"
    
    static func nib() -> UINib
    {
        return UINib(nibName: "MyCustomTableViewCell", bundle: nil)
    }

    public func configure(with title: String, imageName: String)
    {
        myLabel.text = title
        myImageView.image = UIImage(systemName: imageName)
    }
    
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        myImageView.contentMode = .scaleAspectFit

    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

      
    }
    
    
    // method to change custom cell state on user action
  /*
    @available(iOS 14.0, *)
    override func updateConfiguration(using state: UICellConfigurationState)
    {
        super.updateConfiguration(using: state)
        let mSetup = MainVC()
        
        var configuration = defaultContentConfiguration().updated(for: state)
        configuration.text = "Hello"
        configuration.image = UIImage(systemName: "bell")
        
        var backgroundConfig = backgroundConfiguration?.updated(for: state)
        backgroundConfig?.backgroundColor = .red
        
        if state.isHighlighted || isSelected
        {
            backgroundConfig?.backgroundColor = .red
            configuration.textProperties.color = .red
        }

        if mSetup.MainButton?.isEnabled == true
        {
            backgroundConfig?.backgroundColor = .blue
            //backgroundConfig?.backgroundColor = .purple
            print("MAIN BUTTON PRESSED Working")
        }
        
        contentConfiguration = configuration
        backgroundConfiguration = backgroundConfig
    }*/
        
        /*
        
        if mSetup.MainButton?.isEnabled == true && BSetup.
        {
            
            
        }
        
        */
        

}
