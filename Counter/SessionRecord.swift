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
    var note = ""
    
    struct Keys {
        static let recordedCount = "recordedCount"
        static let date = "date"
        static let note = "note"
    }
    
    override init () {}
    
    init(recordedCount: Int, date: String, note: String) {
        self.date = date
        self.recordedCount = recordedCount
        self.note = note
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        
        let sessionRecordCount = decoder.decodeInteger(forKey: Keys.recordedCount)
        recordedCount = sessionRecordCount
        if let sessionRecordDate = decoder.decodeObject(forKey: Keys.date) as? String {
            date = sessionRecordDate
        }
        if let sessionRecordNote = decoder.decodeObject(forKey: Keys.note) as? String {
            date = sessionRecordNote
        }
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.recordedCount, forKey: Keys.recordedCount)
        coder.encode(self.date, forKey: Keys.date)
        coder.encode(self.note, forKey: Keys.note)
    }
}
