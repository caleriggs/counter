//
//  CountsListVC.swift
//  Counter
//
//  Created by Cale Riggs on 2/17/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import UIKit
import Foundation

class CountsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    var timeString = ""
    var store = DataStore.sharedInstance

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
        
            recordCell.updateRecordCellContents(recordedCount: self.store.sessionRecords[indexPath.row].recordedCount, recordedDate: self.store.sessionRecords[indexPath.row].date)
            
            return recordCell
            
            
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.sessionRecords.count

}

//    private func dateFormatter(timeString: inout String) {
//        let now = NSDate()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM dd, yyyy, \r hh:mma zzz"
//        timeString = dateFormatter.string(from: now as Date)
//    }
}

