//
//  CountsListVC.swift
//  Counter
//
//  Created by Cale Riggs on 2/17/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import UIKit

class CountsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    var timeString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let recordCell = tableView.dequeueReusableCell(withIdentifier: "recordedCountCell", for: indexPath) as? RecordCell {
        
            recordCell.updateRecordCellContents(recordedCount: DataStore.sharedInstance.sessionRecords[indexPath.row].recordedCount,
                                                recordedDate: DataStore.sharedInstance.sessionRecords[indexPath.row].date)
            
            return recordCell
            
            
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.sharedInstance.sessionRecords.count

    }
    
//    public func loadData() {
//        
//        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [SessionRecord] {
//            DataStore.sharedInstance.sessionRecords = ourData
//            print("the data loaded, YAAAAAAYYYYY!!!!!")
//            print("here is our data \(ourData)")
//        } else {
//            print("The data didn't load")
//        }
//        
//    }
}

