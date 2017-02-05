//
//  SexTableViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/03.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class SexTableViewCell: UITableViewCell {

    @IBOutlet weak var sexLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCells(at indexpath: IndexPath) {
        var sex: String?
        if let sexCondition = (ModelConditions.sharedInstance.get()["model"] as? [String:Any])?["sex"] as? String {
            switch sexCondition {
            case "1":
                sex = "MEN"
            case "2":
                sex = "WOMEN"
            default:
                sex = "指定なし"
            }
            sexLabel.text = sex!
        } else {
            sexLabel.text = ""
        }
    }

}
