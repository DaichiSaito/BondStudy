//
//  ColorAndBrandViewController.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/03.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class ColorAndBrandViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    var decideFlg: Bool = false
    var backupKaihiFlg: Bool = false
    var currentSelectedColor:[Int]?
    var backupSelectedBrands:[String: Any]?
    var condition: Condition?
    var key:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        self.textField.delegate = self
        let rightButtonItem:UIBarButtonItem = UIBarButtonItem(title: "決定", style:.plain, target: self, action: #selector(ColorAndBrandViewController.decide))
        self.navigationItem.setRightBarButtonItems([rightButtonItem], animated: true)
        
        setSelectedColor()
        backupSelectedBrands = ModelConditions.sharedInstance.get()
        
        ModelConditions.sharedInstance.addObserver(self, forKeyPath: "condition", options: .new, context: nil)

        // Do any additional setup after loading the view.
    }
    deinit {
        ModelConditions.sharedInstance.removeObserver(self, forKeyPath: "condition")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backupKaihiFlg = false
    }
    override func viewDidLayoutSubviews() {
        self.collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    // ModelCondition.conditionを監視 変更があったら再描画
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        NSLog("Called:" + keyPath!)
        if keyPath == "condition" {
            self.tableView.reloadData()
        }
    }
    
    func decide() {
        decideFlg = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func setSelectedColor() {
        currentSelectedColor = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["colors"] as? [Int]
    }
    override func viewWillDisappear(_ animated: Bool) {
        if decideFlg {
            if let indexPaths = self.collectionView?.indexPathsForSelectedItems {
                let selectedColorArray: NSMutableArray = []
                for indexPath  in indexPaths {
                    selectedColorArray.add(indexPath.row)
                }
                var model = ModelConditions.sharedInstance.get()
                var itemsModel = model["item"] as? [String:Any]
                var itemModel = itemsModel?[key] as? [String:Any]
                itemModel?.updateValue(selectedColorArray, forKey: "colors")
                itemsModel?.updateValue(itemModel, forKey: key)
                model.updateValue(itemsModel, forKey: "item")
                ModelConditions.sharedInstance.set(condition: model)
                
            }
        } else if backupKaihiFlg {
            // 今の所ブランド検索への遷移時だけ
        } else {
            // バックアップから戻す
            ModelConditions.sharedInstance.set(condition: backupSelectedBrands!)
        }
        super.viewWillDisappear(animated)
    }
}

extension ColorAndBrandViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionViewの設定開始")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath as IndexPath) as! ColorCollectionViewCell
        if let rows = currentSelectedColor {
            for row in rows {
                if row == indexPath.row {
                    cell.isSelected = true
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
                }
            }
        }
        cell.setCells(at: indexPath)
        return cell
    }
    
    // セルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CodeDef.colors.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ColorAndBrandViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        // 2カラム
        let width: CGFloat = super.view.frame.width / 5
        let height: CGFloat = width
        
        return CGSize(width: width, height: height) // The size of one cell
    }
}

extension ColorAndBrandViewController: UITableViewDataSource {
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int{
        return CodeDef.sectionTitleSelectedBrand.count
    }
    // Sectionのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CodeDef.sectionTitleSelectedBrand[section]
    }
    
    // Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if let count = (((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String])?.count {
                return count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableViewの設定開始")
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectedBrandCell", for: indexPath as IndexPath) as! SelectedBrandTableViewCell
            cell.selectedBrand.text = (((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String])?[indexPath.row]
//            cell.accessoryType = UITableViewCellAccessoryType.detailButton
//            let button = UIButton()
////            let imageView = UIImageView(image: UIImage(named: "peke"))
////            imageView.frame = CGRect(x:0,y:0,width:20,height:20)
//            button.setImage(UIImage(named: "peke"), for: .normal)
//            button.frame = CGRect(x:0,y:0,width:20,height:20)
//            cell.addSubview(button)
//            button.addTarget(self, action: #selector(ColorAndBrandViewController.deleteCell(_:)), for: .touchUpInside)
//            cell.accessoryView = imageView
            cell.key = key
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath as IndexPath)
            return cell
        }
        
    }
//    func deleteCell(_ sender: UIButton) {
//        print((sender.superview as! SelectedBrandTableViewCell).selectedBrand.text)
//    }
    
}


extension ColorAndBrandViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectedBrandTableViewCell
        let brandName:String? = cell.selectedBrand.text
        var selectedBrands = ((ModelConditions.sharedInstance.get()["item"] as? [String:Any])?[key] as? [String:Any])?["brands"] as? [String]
        let index = selectedBrands?.index(of: brandName!)
        selectedBrands?.remove(at: index!)
        
        var model = ModelConditions.sharedInstance.get()
        var itemsModel = model["item"] as? [String:Any]
        var itemModel = itemsModel?[key] as? [String:Any]
        itemModel?.updateValue(selectedBrands, forKey: "brands")
        itemsModel?.updateValue(itemModel, forKey: key)
        model.updateValue(itemsModel, forKey: "item")
        ModelConditions.sharedInstance.set(condition: model)
    }
}

extension ColorAndBrandViewController: UITextFieldDelegate {
    
    //textviewがフォーカスされたら、Labelを非表示
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        let controller = self.storyboard!.instantiateViewController( withIdentifier: "searchBrandViewController" ) as! SearchBrandViewController
        controller.key = key
        backupKaihiFlg = true
        self.navigationController?.pushViewController(controller, animated: false)
        return false
    }
}

