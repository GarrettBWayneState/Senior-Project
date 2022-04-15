//
//  HistoryVC.swift
//  TCM-XXI
//
//  Created by Garrett Berger on 9/25/21.
//  Copyright © 2021 LAGB. All rights reserved.
//
import UIKit

@available(iOS 13.0, *)
class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var TableView: UITableView!
    
    // displays customs cell when array is in this form
    //var dates = ["12/6"]
   // var times = ["1:05"]
    
    
    // prints array elements according to data (CORRECT METHOD)
  //  var dates : [String]?
    //var times : [String]?

    // Confusing method
    /*
    let row = self.mSetup.index(where: {$0.bSetup.blu.monthArrived == Any?})
    if row
    {
           dates[row] = newValue
    }
    array.filter({$0.eventID == id}).first?.added = value
     */

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TableView.register(MyCustomTableViewCell.nib(), forCellReuseIdentifier: MyCustomTableViewCell.identifier)
        TableView.delegate = self
        TableView.dataSource = self

        TableView.backgroundView = nil
        TableView.backgroundColor = UIColor.white
        
        print("\nDates:", dateStorage)
        print("Times:", timeStorage)
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dateStorage.count     // returns number of elements in dates array, if 2 elements then tableUI has 2 rows
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100          // returns size in height each row should be
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        // custom cell setup for mail arrived
        let mailHereCell = tableView.dequeueReusableCell(withIdentifier: MyCustomTableViewCell.identifier, for: indexPath) as! MyCustomTableViewCell
        
        let row = indexPath.row
        let date = dateStorage[row]
        let time = timeStorage[row]
        
        mailHereCell.configure(with: date + "             " + time, imageName: "mailHereImage") // configures custom cell layout

        if arrivedStorage[row]
        {
            mailHereCell.myImageView.image = UIImage(named: "mailHereImage")                    // mailHereImage
            mailHereCell.backgroundColor = UIColor.green
        }
        else
        {
            mailHereCell.myImageView.image = UIImage(named: "mailNotHereImage")                    // mailHereImage
            mailHereCell.backgroundColor = UIColor.red
        }
        
        return mailHereCell
        

    }

}
