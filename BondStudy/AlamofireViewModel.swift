//
//  AlamofireViewModel.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/02.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import Foundation
import Bond
import Alamofire
import SwiftyJSON

class AlamofireViewModel: NSObject {

    let nails = MutableObservableArray<Nail>([Nail]())
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
                        let nail = Nail(json: subJson)
                        self.nails.append(nail)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
