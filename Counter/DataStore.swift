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
    
    
    var filePath: String {
        
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        print("the url is \(String(describing: url))")
        return (url!.appendingPathComponent("Data").path)
        
    }
    
    static func loadData() {
        
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.sharedInstance.filePath) as? [SessionRecord] {
            DataStore.sharedInstance.sessionRecords = ourData
        }
        
    }
    
    static func saveData(recordedCount: String, date: String, note: String) {
        
        DataStore.sharedInstance.sessionRecords.append(SessionRecord(recordedCount: recordedCount, date: date, note: note))
        NSKeyedArchiver.archiveRootObject(DataStore.sharedInstance.sessionRecords, toFile: DataStore.sharedInstance.filePath)
        
    }
    

    
    
}
