//
//  ItemTableViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/03.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var noSelectLabel: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var selectedBrandNames: UILabel!
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var colorView2: UIView!
    @IBOutlet weak var colorView3: UIView!
    var selectedColorArray = [UIView]()
    var key:String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCells(at indexPath: IndexPath) {
        selectedColorArray = [colorView1,colorView2,colorView3]
        self.itemName.text = CodeDef.itemsArray[indexPath.row][0]
        
        // 一旦全部見えなくする
        for selectedColor in selectedColorArray {
            selectedColor.isHidden = true
        }
        
        var somethingSelected: Bool = false
        if let itemTopConditionsColor = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["colors"] as? [Int] {
            //            var index: Int = 0
            for (index, itemTopCondition) in itemTopConditionsColor.enumerated() {
                somethingSelected = true
                if index == 3 {
//                    overLabelForColor.isHidden = false
                    break
                }
                (selectedColorArray[index]).backgroundColor = CodeDef.colors[itemTopCondition].color// as? UIColor
                (selectedColorArray[index]).layer.cornerRadius = 7.5 //どれくらい丸くするのか
                (selectedColorArray[index]).layer.masksToBounds = true //viewに丸くする許可を出す
                (selectedColorArray[index]).layer.borderColor = UIColor.black.cgColor
                (selectedColorArray[index]).isHidden = false
                
            }
        }
        
        if let itemTopConditionsBrand = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String] {
            if itemTopConditionsBrand.count == 0 {
                self.selectedBrandNames.text = ""
                
            } else {
                somethingSelected = true
                var tmpText: String = ""
                for brandText in itemTopConditionsBrand {
                    if let brandName = brandText as String! {
                        tmpText += brandName + ","
                    }
                }
                let currentIndex = tmpText.index(tmpText.endIndex, offsetBy: -1)
                let subStr = tmpText.substring(to:currentIndex)
                self.selectedBrandNames.text = subStr
            }
        }
        
        if somethingSelected {
            noSelectLabel.text = ""
        } else {
            noSelectLabel.text = "指定なし"
        }
    }

}
