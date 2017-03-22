//
//  ViewController.swift
//  Counter
//
//  Created by Cale Riggs on 2/6/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var confirmResetBtn: UIButton!
    @IBOutlet weak var rejectResetBtn: UIButton!
    
    var count = 0
    var timeString = ""
    
//    var countArr = [RecordedCount]()
    
    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLbl.text = "0"
        dateFormatter(timeString: &timeString)
        print("The date and time is \(timeString)")
        
    }
    
//MARK: IBActions
    

    @IBAction func onAddBtnPressed(_ sender: Any) {
        
        count += 1
        countLblManager()
        
    }

    @IBAction func onMinusBtnPressed(_ sender: Any) {
        
        count -= 1
        countLblManager()
        
    }
    
    @IBAction func onResetBtnPressed(_ sender: Any) {
        triggerModeChage()
    }
    
    @IBAction func onConfirmBtnPressed(_ sender: Any) {
        
        count = 0
        countLblManager()
        triggerModeChage()
        
    }
    
    @IBAction func onRejectResetBtnPressed(_ sender: Any) {
        triggerModeChage()
        
    }
    
    @IBAction func onSubmitBtnPressed(_ sender: Any) {
        
        store.recordedCount.append(RecordedCount(count: count, date: timeString))
        dateFormatter(timeString: &timeString)
        print("The date and time is \(timeString)")
        
        
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
        if count < 0 {
            count = 0
        }
        countLbl.text = "\(count)"
    }
    
    private func dateFormatter(timeString: inout String) {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy, hh:mma zzz"
        timeString = dateFormatter.string(from: now as Date)
    }

}
    //MARK: NSKeyedArchiver

    var filePath: String {

    let manager = FileManager.default
    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
    print("the url is \(url)")
    return (url!.appendingPathComponent("Data").path)
    
    }

//    func saveData(record: RecordedCount) {
//        DataStore.sharedInstance.RecordedCount.append(RecordedCount(count: record, date: ))
//    }






