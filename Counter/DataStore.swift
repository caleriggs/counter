//
//  DataStore.swift
//  Counter
//
//  Created by Cale Riggs on 3/27/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import Foundation

class DataStore {
    
    static let sharedInstance = DataStore()
    private init() {}
    var sessionRecords = [SessionRecord]()
    
}
