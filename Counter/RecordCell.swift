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
    
    public func updateRecordCellContents(recordedCount: String, recordedDate: String, recordedNote: String) {
        recordedCountLbl.text = recordedCount
        recordedDateLbl.text = recordedDate
        recordedNoteLbl.text = recordedNote
    }
    
}
