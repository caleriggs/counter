//
//  RecordCell.swift
//  Counter
//
//  Created by Cale Riggs on 3/21/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import Foundation
import UIKit

class RecordCell: UITableViewCell {
    
    @IBOutlet weak var recordedCountLbl: UILabel!
    @IBOutlet weak var recordedDate: UILabel!
    
//    private var store = DataStore.sharedInstance.recordedCount
//    var countString = DataStore.sharedInstance.recordedCount
    
    func updateCellContents() {
        recordedCountLbl.text = ""
    }
    
}
