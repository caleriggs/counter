//
//  CountsListVC.swift
//  Counter
//
//  Created by Cale Riggs on 2/17/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import UIKit
import MessageUI

class CountsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    var timeString = ""
    var deleteRowIndexPath: IndexPath? = nil
    
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
        
            recordCell.updateRecordCellContents(recordedCount: DataStore.sharedInstance.sessionRecords[indexPath.row].recordedCount,
                                                recordedDate: DataStore.sharedInstance.sessionRecords[indexPath.row].date,
                                                recordedNote: DataStore.sharedInstance.sessionRecords[indexPath.row].note)
            
            return recordCell
            
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.init(red: 240/255, green: 151/255, blue: 60/255, alpha: 0.5)
        } else {
            cell.backgroundColor = UIColor.init(red: 88/255, green: 199/255, blue: 175/255, alpha: 0.5)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.sharedInstance.sessionRecords.count

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteRowIndexPath = indexPath
            let rowToDelete = DataStore.sharedInstance.sessionRecords[indexPath.row]
            confirmDelete(recordedSession: rowToDelete)
            self.tableView.reloadData()
        }

    }
    
    //MARK: Alert, Alert handlers
    
    func confirmDelete(recordedSession: Any){
        let alert = UIAlertController(title: "Delete Session Record", message: "Are you sure you want to delete this record?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteRow)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteRow)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        show(alert, sender: self)
    
    }
    
    func handleDeleteRow (_ alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteRowIndexPath {
            tableView.beginUpdates()
            
            DataStore.sharedInstance.sessionRecords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            NSKeyedArchiver.archiveRootObject(DataStore.sharedInstance.sessionRecords, toFile: DataStore.sharedInstance.filePath)

            tableView.endUpdates()
        }
    }
    
    func cancelDeleteRow (_ alertAction: UIAlertAction!) -> Void {
        deleteRowIndexPath = nil
    }

}



