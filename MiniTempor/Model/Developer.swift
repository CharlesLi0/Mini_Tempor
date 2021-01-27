//
//  Developer.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 12/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import UIKit

//This model is used for Facial Recognition purposes
struct Developer {
    
    //Attibutes of the object
    private (set) var name: String
    private (set) var image: UIImage
    
    //Initialization
    public init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
