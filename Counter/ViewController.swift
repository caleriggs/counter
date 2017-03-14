//
//  ViewController.swift
//  Counter
//
//  Created by Cale Riggs on 2/6/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import UIKit
import Material
import RealmSwift

class ViewController: UIViewController {
    
    
    @IBOutlet weak var addBtn: AddButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var confirmResetBtn: UIButton!
    @IBOutlet weak var rejectResetBtn: UIButton!
    
    var count = 0
    
    let counts = List<Count>()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLbl.text = "0"
    
    }
    
//MARK: IBActions
    

    @IBAction func onAddBtnPressed(_ sender: Any) {
        
        count += 1
        countLbl.text = "\(count)"
        
        if count < 0 {
            count = 0
            countLbl.text = "\(count)"
        }
        
    }

    @IBAction func onMinusBtnPressed(_ sender: Any) {
        
        count -= 1
        countLbl.text = "\(count)"
        
        if count < 0 {
            count = 0
            countLbl.text = "\(count)"
        }
        
    }

    @IBAction func onResetBtnPressed(_ sender: Any) {
        
        resetBtn.isHidden = true
        confirmResetBtn.isHidden = false
        rejectResetBtn.isHidden = false
    
        
    }
    
    @IBAction func onConfirmBtnPressed(_ sender: Any) {
        
        count = 0
        countLbl.text = "\(count)"
        
        resetBtn.isHidden = false
        confirmResetBtn.isHidden = true
        rejectResetBtn.isHidden = true
        
    }
    
    @IBAction func onRejectResetBtnPressed(_ sender: Any) {
        
        resetBtn.isHidden = false
        confirmResetBtn.isHidden = true
        rejectResetBtn.isHidden = true
        
    }
    
    @IBAction func onSubmitBtnPressed(_ sender: Any) {
        
        
        
    }
    
//MARK: Realm Functions
    
    func submitCount() {
        
        let realm = try! Realm()
        
        
        
    }
    


}

