//
//  Nail.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/02.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import SwiftyJSON

class Nail {
    let profile_image_url: String
    
    init(json: JSON) {
        self.profile_image_url = json["user"]["profile_image_url"].stringValue
    }
    
//    func fetchImageIfNeeded(){
//        if self.userImage.value != nil {
//            // already have photo
//            return
//        }
//        if let userImageURL = self.userImageURL {
//            let downloadTask = URLSession.shared.downloadTask(with: userImageURL, completionHandler: {
//                [weak self] location, response, error in
//                if let location = location {
//                    if let data = try? Data(contentsOf: location) {
//                        if let image = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                // this will automatically update photo in bonded image view
//                                self?.userImage.value = image
//                                return
//                            }
//                        }
//                    }
//                }
//            })
//            downloadTask.resume()
//        }
//    }
}
