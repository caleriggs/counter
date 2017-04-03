//
//  LoadData.swift
//  Counter
//
//  Created by Cale Riggs on 4/3/17.
//  Copyright © 2017 Cale Riggs. All rights reserved.
//

import Foundation

class LoadData {
    
    static let loadinstance = LoadData()
    private init (){}
    
    func loadData() {
        
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.sharedInstance.filePath) as? [SessionRecord] {
            DataStore.sharedInstance.sessionRecords = ourData
            print("the data loaded, YAAAAAAYYYYY!!!!!")
            print("here is our data \(ourData)")
        } else {
            print("The data didn't load")
        }
        
    }
}
