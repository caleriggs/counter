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
        
            let data = defaults.object(forKey: "recordedCountArr") as? [RecordedCount]
            
            recordCell.updateRecordCellContents(recordedCount: 5, recordedDate: timeString)
            
            return recordCell
            
            
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrCount = [RecordedCount]()
        if let stuff = defaults.object(forKey: "recordedCountArr") as? [RecordedCount] {
            print("here's the array \(stuff)")
        }
        return arrCount.count
    }
}

private func dateFormatter(timeString: inout String) {
    let now = NSDate()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd, yyyy, hh:mma zzz"
    timeString = dateFormatter.string(from: now as Date)
}

func returnData() {
    
}


