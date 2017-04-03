//
//  ViewController.swift
//  Counter
//
//  Created by Cale Riggs on 2/6/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var confirmResetBtn: UIButton!
    @IBOutlet weak var rejectResetBtn: UIButton!
    
    var originalCount: Int = 0
    var timeString = ""

    
//MARK: IBActions
    

    @IBAction func onAddBtnPressed(_ sender: Any) {
        
        originalCount += 1
        countLblManager()
        
    }

    @IBAction func onMinusBtnPressed(_ sender: Any) {
        
        originalCount -= 1
        countLblManager()
        
    }
    
    @IBAction func onResetBtnPressed(_ sender: Any) {
        triggerModeChage()
    }
    
    @IBAction func onConfirmBtnPressed(_ sender: Any) {
        
        originalCount = 0
        countLblManager()
        triggerModeChage()
        
    }
    
    @IBAction func onRejectResetBtnPressed(_ sender: Any) {
        triggerModeChage()
        
    }
    
    @IBAction func onSubmitBtnPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Submit Record", message: "Would you like to record this count?", preferredStyle: .alert)
        
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Add a note/title here (Optional)."
            textField.keyboardAppearance = .dark
            textField.text = " "
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result: UIAlertAction) -> Void in
            print("Cancel")
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (result: UIAlertAction) -> Void in
            self.dateFormatter(timeString: &self.timeString)
            print("The date and time is \(self.timeString)")
//            var textFieldText: String?
            
            guard let textFieldText = alertController.textFields?[0].text else {
                print("there's something there")
                return
            }
        
            self.saveData(recordedCount: self.originalCount, date: self.timeString, note: textFieldText)
            }
        
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            show(alertController, sender: self)
                
        }
        
        
    
    @IBAction func onViewBtnPressed(_ sender: Any) {
        loadData()
    }
    
    //MARK: FUNCTIONS
    
    private func triggerModeChage() {
        resetBtn.isHidden = !resetBtn.isHidden
        confirmResetBtn.isHidden = !confirmResetBtn.isHidden
        rejectResetBtn.isHidden = !rejectResetBtn.isHidden
        addBtn.isHidden = !addBtn.isHidden
        minusBtn.isHidden = !minusBtn.isHidden
    }
    
    private func countLblManager() {
        if originalCount < 0 {
            originalCount = 0
        }
        countLbl.text = "\(originalCount)"
    }
    
    func dateFormatter(timeString: inout String) {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy \r hh:mma zzz"
        timeString = dateFormatter.string(from: now as Date)
    }
    
    //MARK: NSKeyedArchiver
    
    func saveData(recordedCount: Int, date: String, note: String) {
        
        DataStore.sharedInstance.sessionRecords.append(SessionRecord(recordedCount: recordedCount, date: date, note: note))
        NSKeyedArchiver.archiveRootObject(DataStore.sharedInstance.sessionRecords, toFile: DataStore.sharedInstance.filePath)
        
    }
    
    func loadData() {
        
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.sharedInstance.filePath) as? [SessionRecord] {
            DataStore.sharedInstance.sessionRecords = ourData
            print("the data loaded, YAAAAAAYYYYY!!!!!")
            print("here is our data \(ourData)")
        } else {
            print("The data didn't load")
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLbl.text = "0"
        dateFormatter(timeString: &timeString)
        print("The date and time is \(timeString)")
        
        loadData()
        
        addBtn.layer.cornerRadius = 5
        minusBtn.layer.cornerRadius = 5
        resetBtn.layer.cornerRadius = 5
        
        confirmResetBtn.layer.borderColor = UIColor.init(red: 240/255, green: 151/255, blue: 60/255, alpha: 1).cgColor
        confirmResetBtn.layer.borderWidth = 3
        confirmResetBtn.layer.cornerRadius = 5
        
        rejectResetBtn.layer.borderColor = UIColor.init(red: 88/255, green: 199/255, blue: 175/255, alpha: 1).cgColor
        rejectResetBtn.layer.borderWidth = 3
        rejectResetBtn.layer.cornerRadius = 5
        
    }

}















