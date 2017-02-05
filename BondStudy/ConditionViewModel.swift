//
//  ConditionViewModel.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/02.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import Foundation
import Bond
import Alamofire
import SwiftyJSON

class ConditionViewModel: NSObject {
    
    var conditions = MutableObservableArray<Condition>([Condition]())
    //    let nails = MutableObservableArray<Nail>()
    
//    func request2() {
//        // 本来はこれはuserDefaultからとってくる
//        let value: [String: Any] = [
//            "tops": [
//                "colors":["1","2","3"],
//                "brands":["ナイキ","アディダス","プーマ"]
//            ],
//            "pants": [
//                "colors":["1","2","3"],
//                "brands":["ナイキ","アディダス","プーマ"]
//            ],
//            "outer": [
//                "colors":["1","2","3"],
//                "brands":["ナイキ","アディダス","プーマ"]
//            ],
//            "shose": [
//                "colors":["1","2","3"],
//                "brands":["ナイキ","アディダス","プーマ"]
//            ],
//            "hat": [
//                "colors":["1","2","3"],
//                "brands":["ナイキ","アディダス","プーマ"]
//            ],
//            "neck": [
//                "colors":["1","2","3"],
//                "brands":["ナイキ","アディダス","プーマ"]
//            ]
//        ]
//        let json = JSON(value)
//        print(json)
//        for (_, subJson) in json {
//            let condition = Condition(json: subJson)
//            self.conditions.append(condition)
//        }
//        
//    }
    func getCondition() {
        let condition = UserDefaults.standard.object(forKey: "CONDITION")
//        let condition = UserDefaults.standard.object(forKey: "CONDITION2")
        if let condition = condition {
            let json = JSON(condition)
            for (key, subJson) in json {
//                print(key)// item,tagとか
                if key == "item" {
                    // itemの場合はネストされているのでさらにfor文で回す
                    for (key, subsubJson) in subJson {
                        if key == "season" {
                            // seasonの場合は
                            continue
                        }
//                        print(key)
                        let condition = Condition(json: subsubJson, key: key)
                        self.conditions.append(condition)
                    }
                    
                }
                
            }
//            viewModel.conditions = condition
        } else {
            print("なんもないよー")
        }
    }


}
