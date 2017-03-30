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
    @IBOutlet weak var recordedDateLbl: UILabel!
    @IBOutlet weak var recordedNoteLbl: UILabel!
    
    
//    private var store = DataStore.sharedInstance.recordedCount
//    var countString = DataStore.sharedInstance.recordedCount
    
    public func updateRecordCellContents(recordedCount: Int, recordedDate: String, recordedNote: String) {
        recordedCountLbl.text = "\(recordedCount)"
        recordedDateLbl.text = recordedDate
        recordedNoteLbl.text = recordedNote
    }
    
}
