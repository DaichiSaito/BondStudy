//
//  ColorCollectionViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/03.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    func setCells(at indexPath: IndexPath) {
        self.bgView.backgroundColor = CodeDef.colors[indexPath.row].color
        // ラベル
//        self.colorText.text = CodeDef.colors[indexPath.row].colorText
        // 丸く
        self.bgView.layer.cornerRadius = 15.0 //どれくらい丸くするのか
        self.bgView.layer.masksToBounds = true //viewに丸くする許可を出す
        self.bgView.layer.borderColor = UIColor.black.cgColor
        self.bgView.layer.borderWidth = 1
        
        // チェックマーク
        if isSelected {
            self.checkImageView.isHidden = false
        } else {
            self.checkImageView.isHidden = true
        }
    }
    
    override var isSelected: Bool {
        didSet {
            //            self.colorView.alpha = isSelected ? 0.4 : 1.0
            if isSelected {
                print("selected")
                self.checkImageView.isHidden = false
            } else {
                print("deselected")
                self.checkImageView.isHidden = true
            }
        }
    }
    
}
