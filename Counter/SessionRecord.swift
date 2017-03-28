//
//  SessionRecord.swift
//  Counter
//
//  Created by Cale Riggs on 3/13/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import Foundation

class SessionRecord: NSObject, NSCoding {
    
    var recordedCount = 0
    var date = ""
    
    struct Keys {
        static let recordedCount = "recordedCount"
        static let date = "date"
    }
    
    init(recordedCount: Int, date: String) {
        self.date = date
        self.recordedCount = recordedCount
    }
    
    required init(coder decoder: NSCoder) {
        
        if let sessionRecordCount = decoder.decodeObject(forKey: Keys.recordedCount) as? Int {
            recordedCount = sessionRecordCount
        }
        if let sessionRecordDate = decoder.decodeObject(forKey: Keys.date) as? String {
            date = sessionRecordDate
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(recordedCount, forKey: Keys.recordedCount)
        coder.encode(date, forKey: Keys.date)
    }
    
    
    
}
