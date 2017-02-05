//
//  ModelBase.swift
//  GolfWear
//
//  Created by DaichiSaito on 2017/01/11.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//
import UIKit
class ModelBase: NSObject {
    
    dynamic var condition: [String: Any] = [:]
    
    func get() -> [String: Any] {
        return self.condition
    }
    
    func set(condition: [String: Any]) {
        self.condition = condition
    }
}
