//
//  Condition.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/02.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
class Condition {
    var colors = [String]()
    var brands = [String]()
    
    
    init(json: JSON) {
        self.colors = json["colors"].arrayObject as! [String]
        self.brands = json["brands"].arrayObject as! [String]
    }

}
