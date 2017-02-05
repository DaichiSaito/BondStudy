//
//  BrandTableViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/04.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var brandName: UILabel!
    var key: String = ""
    var touchStatus: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCells(at indexPath: IndexPath) {
        // ブランド名
        brandName.text = CodeDef.dataList[indexPath.row]
        // 選択済みかどうか
        let selectedBrands = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String]
        if (selectedBrands?.contains(brandName.text!))! {
            accessoryType = UITableViewCellAccessoryType.checkmark
            touchStatus = true
        } else {
            accessoryType = UITableViewCellAccessoryType.none
            touchStatus = false
        }
    }
    
    func changeCell(at indexPath: IndexPath) {
        if !(touchStatus) {
            // falseだった場合（未選択→選択）
            accessoryType = UITableViewCellAccessoryType.checkmark
            let brandName = CodeDef.dataList[indexPath.row]
//            BrandsModel.sharedInstance.selectedBrands.append(brandName)
            var selectedBrands = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String]
            selectedBrands?.append(brandName)
            var model = ModelConditions.sharedInstance.get()
            var itemsModel = model["item"] as? [String:Any]
            var itemModel = itemsModel?[key] as? [String:Any]
            itemModel?.updateValue(selectedBrands, forKey: "brands")
            itemsModel?.updateValue(itemModel, forKey: key)
            model.updateValue(itemsModel, forKey: "item")
            ModelConditions.sharedInstance.set(condition: model)
        } else {
            accessoryType = UITableViewCellAccessoryType.none
            let brandName = CodeDef.dataList[indexPath.row]
            var selectedBrands = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String]
            let index = selectedBrands?.index(of: brandName)
            selectedBrands?.remove(at: index!)
            
            var model = ModelConditions.sharedInstance.get()
            var itemsModel = model["item"] as? [String:Any]
            var itemModel = itemsModel?[key] as? [String:Any]
            itemModel?.updateValue(selectedBrands, forKey: "brands")
            itemsModel?.updateValue(itemModel, forKey: key)
            model.updateValue(itemsModel, forKey: "item")
            ModelConditions.sharedInstance.set(condition: model)
        }
        touchStatus = !touchStatus
    }

}
