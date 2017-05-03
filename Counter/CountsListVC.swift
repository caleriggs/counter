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
    
    var timeString = ""
    var deleteRowIndexPath: IndexPath? = nil
    let defaults = UserDefaults.standard
    var emailBody = "Here are your recorded counts: "
    var isEmailPermissionGranted = false
    
    struct defaultKeys {
        static let emailPermissionGranted = "emailPermissionGranted"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        isEmailPermissionGranted = defaults.bool(forKey: defaultKeys.emailPermissionGranted)
        emailBodyHtml()
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func composeButtonPressed(_ sender: Any) {
        if isEmailPermissionGranted == true {
            presentMailVC()
        } else {
            emailPermissionAlert()
        }
        
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
        deleteRow()
    }
    
    func cancelDeleteRow (_ alertAction: UIAlertAction!) -> Void {
        deleteRowIndexPath = nil
    }
    
    
    func deleteRow () {
        if let indexPath = deleteRowIndexPath {
            tableView.beginUpdates()
            
            DataStore.sharedInstance.sessionRecords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            NSKeyedArchiver.archiveRootObject(DataStore.sharedInstance.sessionRecords, toFile: DataStore.sharedInstance.filePath)
            
            tableView.endUpdates()
        }
    }
    
    //MARK: Email contents
    
    func configuredMailComposeVC(body: String) -> MFMailComposeViewController {
        
        emailBodyHtml()
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setMessageBody(body, isHTML: true)
        
        return mailComposerVC
    }
    
    func emailBodyHtml() {
        
        let store = DataStore.sharedInstance.sessionRecords
        for records in store {
            let bodyLine = "<dl><dt>Note: \(records.note)</dt> <dd> - Recorded Count:\(records.recordedCount)</dd> <dd>- Date: \(records.date)</dd><br>"
            emailBody += bodyLine
            print(bodyLine)
        }
    }
    
    func showMailErrorAlert() {
        let mailErrorAlert = UIAlertController(title: "Cannot Send Email", message: "Please make sure your email is configured properly", preferredStyle: .alert)
        show(mailErrorAlert, sender: self)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
//    func emailCompletionHandler() {
//        emailBody = ""
//    }
    
    //MARK: EMAIL PERMISSIONS
    
    func emailPermissionAlert() {
        let alertController = UIAlertController(title: "\"Clicky\" would like access to Mail.", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Don't Allow", style: .cancel, handler: handleEmailPermissionDenied)
        let allowAction = UIAlertAction(title: "Allow", style: .default, handler: handleEmailPermissionGranted)
        
        alertController.addAction(cancelAction)
        alertController.addAction(allowAction)
        
        show(alertController, sender: self)
    }
    
    func handleEmailPermissionDenied(_ alertAction: UIAlertAction!) -> Void {
        
    }
    
    func handleEmailPermissionGranted(_ alertAction: UIAlertAction!) -> Void {
        defaults.set(true, forKey: defaultKeys.emailPermissionGranted)
        isEmailPermissionGranted = defaults.bool(forKey: defaultKeys.emailPermissionGranted)
        emailBodyHtml()
        presentMailVC()
    }
    
    func presentMailVC() {
        let mailComposeVC = configuredMailComposeVC(body: emailBody)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            showMailErrorAlert()
        }
    }
    
}





