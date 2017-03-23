//
//  Count.swift
//  Counter
//
//  Created by Cale Riggs on 3/13/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import Foundation

class RecordedCount: NSObject, NSCoding {
    
    private var _count = 0
    private var _date = ""
    
    var count: Int {
        return _count
    }
    
    var date: String {
        get {
            return _date
        } set {
            _date = newValue
        }
    }
    
    struct Keys {
        static let _count = "count"
        static let _date = "date"
    }
    
    init(count: Int, date: String) {
        self._date = date
        self._count = count
    }
    
    required init(coder decoder: NSCoder) {
        if let recordedCount = decoder.decodeObject(forKey: Keys._count) as? Int {
            _count = recordedCount
        }
        if let recordedDate = decoder.decodeObject(forKey: Keys._date) as? String {
            _date = recordedDate
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_count, forKey: Keys._count)
        aCoder.encode(_date, forKey: Keys._date)
    }
    
}
