//
//  Count.swift
//  Counter
//
//  Created by Cale Riggs on 3/13/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import Foundation

class Count: NSObject, NSCoding {
//Change the name to something like "record" 
    
    
    private var _count = 0
    private var _date = ""
    
    struct Keys {
        static let _count = "count"
        static let _date = "date"
    }
    
    init(count: Int) {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy, hh:mma zzz"
        let timeString = dateFormatter.string(from: now as Date)
        self._date = timeString
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
    
    var count: Int {
        get {
            return _count
        }
        set {
            _count = newValue
        }
    }
    
    var date: String {
        get {
            return _date
        }
        
        set {
            _date = newValue
        }
    }
    
    
    

}
