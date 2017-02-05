//
//  TallTableViewCell.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/03.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class TallTableViewCell: UITableViewCell {

    @IBOutlet weak var tallLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCells(at indexpath: IndexPath) {
        if let tallCondition = (ModelConditions.sharedInstance.get()["model"] as? [String:Any])?["tall"] as? [String] {
            tallLabel.text = "\(tallCondition[0])〜\(tallCondition[1])cm"
        } else {
            tallLabel.text = ""
        }
    }
    
    private var _inputView: UIView?
    override var inputView: UIView? {
        get {
            return _inputView
        }
        set {
            _inputView = newValue
        }
    }
    
    private var _inputAccessoryView: UIView?
    override var inputAccessoryView: UIView? {
        get {
            return _inputAccessoryView
        }
        set {
            _inputAccessoryView = newValue
        }
    }
    
    override var canBecomeFirstResponder: Bool { get { return true } }

}
