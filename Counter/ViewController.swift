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
        
        dateFormatter(timeString: &timeString)
//        store.sessionRecords.append(SessionRecord(recordedCount: originalCount, date: timeString))
        print("The date and time is \(timeString)")
        saveData(recordedCount: originalCount, date: timeString)

    }
    
    @IBAction func onViewBtnPressed(_ sender: Any) {
        loadData()
    }
    
    //MARK: FUNCTIONS
    
    private func triggerModeChage() {
        resetBtn.isHidden = !resetBtn.isHidden
        confirmResetBtn.isHidden = !confirmResetBtn.isHidden
        rejectResetBtn.isHidden = !rejectResetBtn.isHidden
        addBtn.isEnabled = !addBtn.isEnabled
        minusBtn.isEnabled = !minusBtn.isEnabled
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
    
    public var filePath: String {
        
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        print("the url is \(String(describing: url))")
        return (url!.appendingPathComponent("Data").path)
        
    }
    
    func saveData(recordedCount: Int, date: String) {
        
        DataStore.sharedInstance.sessionRecords.append(SessionRecord(recordedCount: recordedCount, date: date))
        NSKeyedArchiver.archiveRootObject(DataStore.sharedInstance.sessionRecords, toFile: filePath)
        
    }
    
    public func loadData() {
        
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [SessionRecord] {
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
        
        print(DataStore.sharedInstance.sessionRecords)
        
    }

}















