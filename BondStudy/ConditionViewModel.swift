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
    
    func request(){
        let url = "https://qiita.com/api/v2/items"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    //                    print(value)
                    let json = JSON(value)
                    print(json)
                    for (_, subJson) in json {
                        //                        let feed = Nail(title: subJson["title"].string,
                        //                                        username: subJson["user"]["id"].string,
                        //                                        userImageURL: subJson["user"]["profile_image_url"].string,
                        //                                        url: subJson["url"].string
                        //                        )
                        let condition = Condition(json: subJson)
                        self.conditions.append(condition)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func request2() {
        // 本来はこれはuserDefaultからとってくる
        let value: [String: Any] = [
            "tops": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ],
            "pants": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ],
            "outer": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ],
            "shose": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ],
            "hat": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ],
            "neck": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ]
        ]
        let json = JSON(value)
        print(json)
        for (_, subJson) in json {
            let condition = Condition(json: subJson)
            self.conditions.append(condition)
        }
        
    }
    func getCondition() {
        let condition = UserDefaults.standard.object(forKey: "CONDITION")
        if let condition = condition {
//            print(condition)
            let json = JSON(condition)
//            print(json)
            for (key, subJson) in json {
                print(key)
                if key == "item" {
                    for (key, subsubJson) in subJson {
                        if key == "season" {
                            continue
                        }
                        let condition = Condition(json: subsubJson)
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
