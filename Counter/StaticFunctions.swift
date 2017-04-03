//
//  StaticFunctions.swift
//  Counter
//
//  Created by Cale Riggs on 4/3/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import Foundation

class StaticFunctions {
    
    static func loadData() {
        
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.sharedInstance.filePath) as? [SessionRecord] {
            DataStore.sharedInstance.sessionRecords = ourData
            print("the data loaded, YAAAAAAYYYYY!!!!!")
            print("here is our data \(ourData)")
        } else {
            print("The data didn't load")
        }
        
    }
    
    static func saveData(recordedCount: Int, date: String, note: String) {
        
        DataStore.sharedInstance.sessionRecords.append(SessionRecord(recordedCount: recordedCount, date: date, note: note))
        NSKeyedArchiver.archiveRootObject(DataStore.sharedInstance.sessionRecords, toFile: DataStore.sharedInstance.filePath)
        
    }
}
