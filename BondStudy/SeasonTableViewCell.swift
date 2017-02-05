//
//  SeasonTableViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/03.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class SeasonTableViewCell: UITableViewCell {

    @IBOutlet weak var winterButton: UIButton!
    @IBOutlet weak var autumnButton: UIButton!
    @IBOutlet weak var summerButton: UIButton!
    @IBOutlet weak var springButton: UIButton!
    
    var buttonArray = [UIButton]()
//    var isSelectedFlg:[Bool] = [false,false,false,false] //春,夏,秋,冬
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonArray = [springButton,summerButton,autumnButton,winterButton]
        
        for button in buttonArray {
            button.addTarget(self, action: #selector(SeasonTableViewCell.tapAction(_:)), for: .touchUpInside)
        }
        if let conditionSeason = (ModelConditions.sharedInstance.get()["item"] as? [String:Any])?["season"] as? [Bool] {
            if conditionSeason.count != 4 {
                // 一時的にこの条件を入れてる。
                // ModelConditionにseason条件が[]ってのがありえちゃってたから。
            } else {
//                isSelectedFlg = conditionSeason
            }
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCells(indexPath: IndexPath) {
        // 以下2行が丸くする処理
        for (index, button) in buttonArray.enumerated() {
            button.layer.cornerRadius = 15.0
            button.layer.masksToBounds = true //viewに丸くする許可を出す
            button.layer.borderColor = self.tintColor.cgColor
            button.layer.borderWidth = 1
            
            let isSelectedFlg = (ModelConditions.sharedInstance.get()["item"] as? [String:Any])?["season"] as? [Bool]
            if (isSelectedFlg?[index])! {
                setButtonStatus(isSelect: true, sender: button)
            } else {
                setButtonStatus(isSelect: false, sender: button)
            }
        }
    }
    
    func tapAction(_ sender: UIButton) {
        print(sender.isSelected)
        // trueできたときはfalseで実行。falseで来た時はtrueで実行
        setButtonStatus(isSelect: !sender.isSelected, sender: sender)

        var model = ModelConditions.sharedInstance.get()
        var itemsModel = model["item"] as? [String:Any]
        var seasonCondition = itemsModel?["season"] as? [Bool]
        seasonCondition?[sender.tag - 1] = sender.isSelected
        itemsModel?.updateValue(seasonCondition, forKey: "season")
        model.updateValue(itemsModel, forKey: "item")
        ModelConditions.sharedInstance.set(condition: model)
        
    }
    
    func setButtonStatus(isSelect: Bool, sender: UIButton) {
        if isSelect {
            print("選択状態に変えます。")
            sender.backgroundColor = self.tintColor
            sender.setTitleColor(UIColor.white, for: .normal)
        } else {
            print("未選択状態に変えます。")
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(self.tintColor, for: .normal)
        }
//        isSelectedFlg[sender.tag - 1] = isSelect
        sender.isSelected = isSelect
    
    }
}
