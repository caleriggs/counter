//
//  ViewController.swift
//  Counter
//
//  Created by Cale Riggs on 2/6/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var confirmResetBtn: UIButton!
    @IBOutlet weak var rejectResetBtn: UIButton!
    @IBOutlet weak var resetLbl: UILabel!
    
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
            textField.delegate = self
            textField.placeholder = "Optional: Add note (Max Char = 50)"
            textField.keyboardAppearance = .dark
            
            
        }
        
        let cancelAction = UIAlertAction(title: "NO", style: .cancel) { (result: UIAlertAction) -> Void in }
        
        let okAction = UIAlertAction(title: "YES", style: .default) { (result: UIAlertAction) -> Void in
            self.dateFormatter(timeString: &self.timeString)
            
            guard let textFieldText = alertController.textFields?[0].text else {
                return
                }
        
            DataStore.saveData(recordedCount: "\(self.originalCount)", date: self.timeString, note: textFieldText)
            }
        
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            show(alertController, sender: self)
                
        }
        
        
    
    @IBAction func onViewBtnPressed(_ sender: Any) {
        DataStore.loadData()
    }
    
    //MARK: FUNCTIONS
    
    private func triggerModeChage() {
        resetBtn.isHidden = !resetBtn.isHidden
        confirmResetBtn.isHidden = !confirmResetBtn.isHidden
        rejectResetBtn.isHidden = !rejectResetBtn.isHidden
        addBtn.isHidden = !addBtn.isHidden
        minusBtn.isHidden = !minusBtn.isHidden
        resetLbl.isHidden = !resetLbl.isHidden
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
        dateFormatter.dateFormat = "MMMM dd, yyyy hh:mma"
        timeString = dateFormatter.string(from: now as Date)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        return newString.length <= 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLbl.text = "0"
        dateFormatter(timeString: &timeString)

        
        DataStore.loadData()
        
        
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


















