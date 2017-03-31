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
    var deleteRowIndexPath: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.sharedInstance.sessionRecords.count

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteRowIndexPath = indexPath
            let rowToDelete = DataStore.sharedInstance.sessionRecords[indexPath.row]
            confirmDelete(recordedSession: rowToDelete)
        }

    }
    
    func confirmDelete(recordedSession: SessionRecord){
        let alert = UIAlertController(title: "Delete Session Record", message: "Are you sure you want to delete this record?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteRow)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteRow)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
    
    }
    
    func handleDeleteRow (_ alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteRowIndexPath {
            tableView.beginUpdates()
            DataStore.sharedInstance.sessionRecords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteRowIndexPath = nil
            tableView.endUpdates()
        } else { print("nothing here")}
    }
    
    func cancelDeleteRow (_ alertAction: UIAlertAction!) -> Void {
        deleteRowIndexPath = nil
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

