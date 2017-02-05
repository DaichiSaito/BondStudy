//
//  SelectedBrandTableViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/04.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class SelectedBrandTableViewCell: UITableViewCell {
    @IBOutlet weak var selectedBrand: UILabel!
    var key: String = ""

    @IBAction func deleteButton(_ sender: Any) {
        
        var selectedBrands = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String]
        let index = selectedBrands?.index(of: selectedBrand.text!)
        selectedBrands?.remove(at: index!)
        
        var model = ModelConditions.sharedInstance.get()
        var itemsModel = model["item"] as? [String:Any]
        var itemModel = itemsModel?[key] as? [String:Any]
        itemModel?.updateValue(selectedBrands, forKey: "brands")
        itemsModel?.updateValue(itemModel, forKey: key)
        model.updateValue(itemsModel, forKey: "item")
        ModelConditions.sharedInstance.set(condition: model)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
