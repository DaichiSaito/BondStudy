//
//  ConditionTableViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/02.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
class ConditionTableViewCell: UITableViewCell {

    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var color3: UIView!
    @IBOutlet weak var color2: UIView!
    @IBOutlet weak var color1: UIView!
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        userImageView.image = nil
        
        reactive.bag.dispose()
    }
    
    func setCell(condition: Condition, indexPath: IndexPath) {
        // ブランド
        var tmpStr = ""
        for brand in condition.brands {
            tmpStr += brand + ","
        }
        var currentIndex = tmpStr.index(tmpStr.endIndex, offsetBy: -1)
        var subStr = tmpStr.substring(to:currentIndex)
        brandName.text = subStr
        
        // カラー
        for (index, color) in condition.colors.enumerated() {
            switch index {
            case 0:
                color1.backgroundColor = CodeDef.colorDef[color]
            case 1:
                color2.backgroundColor = CodeDef.colorDef[color]
            case 2:
                color3.backgroundColor = CodeDef.colorDef[color]
            default:
                break
            }
        }
        
        // アイテム名
        itemName.text = CodeDef.itemsArray[indexPath.row]
        
    }
    
    
}
