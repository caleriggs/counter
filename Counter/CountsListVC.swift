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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    
    }

    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let recordCell = tableView.dequeueReusableCell(withIdentifier: "recordedCountCell", for: indexPath) as? RecordCell {
            let recordedCount = DataStore.sharedInstance.recordedCountArr[indexPath.row]
            
            
            
            recordCell.updateRecordCellContents(recordedCount: recordedCount.count, recordedDate: recordedCount.date)
            
            return recordCell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.sharedInstance.recordedCountArr.count
    }
}
