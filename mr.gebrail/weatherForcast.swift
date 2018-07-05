//
//  weatherForcast.swift
//  mr.gebrail
//
//  Created by Zyad Galal on 7/5/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import Foundation
import UIKit
class  weatherForcast {
    var dayName : String!
    var imageURL : UIImage!
    var highTemp :Double!
    var lowTemp :Double!
    
    init(name:String , image : UIImage , high:Double , low :Double) {
        dayName = name
        imageURL = image
        highTemp = high
        lowTemp = low
    }
    init() {
        
    }
}
