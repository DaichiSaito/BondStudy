//
//  ModelConditions.swift
//  GolfWear
//
//  Created by DaichiSaito on 2017/01/11.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//



class ModelConditions : ModelBase {
    // 雛形
    static let value: [String: Any] = [
        "item":[
            "season":[],
            "tops": [
                "colors":[],
                "brands":[],
                "title":"トップス"
            ],
            "pants": [
                "colors":[],
                "brands":[],
                "title":"パンツ"
            ],
            "outer": [
                "colors":[],
                "brands":[],
                "title":"アウター"
            ],
            "shose": [
                "colors":[],
                "brands":[],
                "title":"シューズ"
            ],
            "hat": [
                "colors":[],
                "brands":[],
                "title":"ハット"
            ],
            "neck": [
                "colors":[],
                "brands":[],
                "title":"ネック"
            ]
        ],
        "model": [
            "sex":"",
            "tall":[],
            "age":[]
        ],
        "tag":[]
    ]

    
    class var sharedInstance : ModelConditions {
        struct Singleton {
            static var instance = ModelConditions()
        }
        return Singleton.instance
    }
}

