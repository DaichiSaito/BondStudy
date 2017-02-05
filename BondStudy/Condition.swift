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
    var colors = ObservableArray<String>()
    var brands = ObservableArray<String>()
    var key = ""
    var test : Observable<String?>
    
    
    init(json: JSON, key: String) {
        self.colors = ObservableArray(json["colors"].arrayObject as! [String])
        self.brands = ObservableArray(json["brands"].arrayObject as! [String])
        self.key = key
        
        self.test = Observable("aiueo")
    }

}
