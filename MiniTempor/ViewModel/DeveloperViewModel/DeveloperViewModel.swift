//
//  DeveloperViewModel.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 12/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import UIKit

struct DeveloperViewModel {
    
    //Singleton pattern
    static let shared = DeveloperViewModel()
    
    //Reference to the Model
    private (set) var developerList: [Developer] = []
    
    private init() {
        loadData()
    }
    
    mutating private func loadData() {
        let developers = [
            Developer(name: "Chenbo Fu", image: UIImage(named: "Chenbo Fu")!),
            Developer(name: "Chaoming Li", image: UIImage(named: "Chaoming Li")!)
        ]
        
        developerList = developers
    }
    
    mutating func removeDeveloper(at index: Int) {
        developerList.remove(at: index)
    }
    
    mutating func addDeveloper(_ developer: Developer) {
        developerList.append(developer)
    }
}
