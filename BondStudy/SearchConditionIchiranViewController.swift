//
//  SearchConditionIchiranViewController.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/03.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class SearchConditionIchiranViewController: UIViewController {
    
    var selectedAge: [String] = []
    var selectedTall: [String] = []
    
    @IBAction func decideButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(ModelConditions.sharedInstance.get(), forKey:"CONDITION3")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // テーブルビューのデリゲートとデータソース設定
        tableView.delegate = self
        tableView.dataSource = self
        
        if let userDefaultCondition = UserDefaults.standard.object(forKey: "CONDITION3") {
                ModelConditions.sharedInstance.set(condition: userDefaultCondition as! [String : Any])
        } else {
                ModelConditions.sharedInstance.set(condition: ModelConditions.value)
        }
        
        ModelConditions.sharedInstance.addObserver(self, forKeyPath: "condition", options: .new, context: nil)
        
    }
    deinit {
        ModelConditions.sharedInstance.removeObserver(self, forKeyPath: "condition")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ModelCondition.conditionを監視 変更があったら再描画
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        NSLog("Called:" + keyPath!)
        if keyPath == "condition" {
            self.tableView.reloadData()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func onClick(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 1:
            if selectedTall == [] {
                selectedTall = ["151","160"]
            }
            print("\(selectedTall[0])〜\(selectedTall[1])")
            
            var model = ModelConditions.sharedInstance.get()
            var modelModel = model["model"] as? [String:Any]
            modelModel?.updateValue(selectedTall, forKey: "tall")
            model.updateValue(modelModel, forKey: "model")
            ModelConditions.sharedInstance.set(condition: model)
            
        case 2:
            if selectedAge == [] {
                selectedAge = ["0","10"]
            }
            print("\(selectedAge[0])〜\(selectedAge[1])")
            var model = ModelConditions.sharedInstance.get()
            var modelModel = model["model"] as? [String:Any]
            modelModel?.updateValue(selectedAge, forKey: "age")
            model.updateValue(modelModel, forKey: "model")
            ModelConditions.sharedInstance.set(condition: model)
        case 3:
            break
        default:break
        }

    }

}

extension SearchConditionIchiranViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                break
            case 1,2,3,4,5,6,7:
                let controller = self.storyboard!.instantiateViewController( withIdentifier: "colorAndBrandViewController" ) as! ColorAndBrandViewController
                controller.key = CodeDef.itemsArray[indexPath.row][1]
                self.navigationController?.pushViewController(controller, animated: true)
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                let alert: UIAlertController = UIAlertController(title: "性別", message: "性別を選択してください。", preferredStyle:  UIAlertControllerStyle.actionSheet)
                // MENボタン
                let action_MEN: UIAlertAction = UIAlertAction(title: "MEN", style: UIAlertActionStyle.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("MEN")
                    var model = ModelConditions.sharedInstance.get()
                    var modelModel = model["model"] as? [String:Any]
                    modelModel?.updateValue("1", forKey: "sex")
                    model.updateValue(modelModel, forKey: "model")
                    ModelConditions.sharedInstance.set(condition: model)
                })
                let action_WOMEN: UIAlertAction = UIAlertAction(title: "WOMEN", style: UIAlertActionStyle.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("WOMEN")
                    var model = ModelConditions.sharedInstance.get()
                    var modelModel = model["model"] as? [String:Any]
                    modelModel?.updateValue("2", forKey: "sex")
                    model.updateValue(modelModel, forKey: "model")
                    ModelConditions.sharedInstance.set(condition: model)
                })
                
                // Cancelボタン
                let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("cancelAction")
//                    let searchView = self.view as! SearchView
//                    searchView.tableView.reloadData()
                })
                
                alert.addAction(cancelAction)
                alert.addAction(action_MEN)
                alert.addAction(action_WOMEN)
                
                present(alert, animated: true, completion: nil)
                
            case 1:
                let tallCell = tableView.cellForRow(at: indexPath) as! TallTableViewCell
                let tallPicker = UIPickerView()
                tallPicker.showsSelectionIndicator = true
                tallPicker.delegate = self
                tallPicker.dataSource = self
                tallPicker.tag = 1
                
                //closeToolBar作成。ニョキ担当
                let closeToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
                closeToolBar.barStyle = UIBarStyle.default
                closeToolBar.sizeToFit()
                
                // closeの文字を右側に表示させるためのスペーサー
                let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
                
                // ToolBar閉じるボタンを追加
                let myToolBarButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(SearchConditionIchiranViewController.onClick(_:)))
                myToolBarButton.tag = 1
                closeToolBar.items = [spacer, myToolBarButton]
                
                
                tallCell.inputView = tallPicker
                tallCell.inputAccessoryView = closeToolBar
                tallCell.becomeFirstResponder()
                
                
            case 2:
                // 年齢用PickerView作成
                let ageCell = tableView.cellForRow(at: indexPath) as! AgeTableViewCell
                let agePicker = UIPickerView()
                agePicker.showsSelectionIndicator = true
                agePicker.delegate = self
                agePicker.dataSource = self
                agePicker.tag = 2
                
                //closeToolBar作成。ニョキ担当
                let closeToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
                closeToolBar.barStyle = UIBarStyle.default
                closeToolBar.sizeToFit()
                
                // closeの文字を右側に表示させるためのスペーサー
                let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
                
                // ToolBar閉じるボタンを追加
                let myToolBarButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(SearchConditionIchiranViewController.onClick(_:)))
                myToolBarButton.tag = 2
                closeToolBar.items = [spacer, myToolBarButton]
                
                
                ageCell.inputView = agePicker
                ageCell.inputAccessoryView = closeToolBar
                ageCell.becomeFirstResponder()
                
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                break
            case 1:
                break
            default:
                break
            }
        default:
            break
        }
    }
    
}

extension SearchConditionIchiranViewController: UITableViewDataSource {
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = table.dequeueReusableCell(withIdentifier: "seasonCell", for: indexPath) as! SeasonTableViewCell
                return cell
            case 1,2,3,4,5,6,7:
                let cell = table.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
                cell.key = CodeDef.itemsArray[indexPath.row][1]
                cell.setCells(at: indexPath)
//                cell.myItemName = CodeDef.itemsArray[indexPath.row][0]
                return cell
            default:
                return UITableViewCell()//仮
            }
            
            
        case 1:
            switch indexPath.row {
            case 0:
                let cell = table.dequeueReusableCell(withIdentifier: "sexCell", for: indexPath) as! SexTableViewCell
                cell.setCells(at: indexPath)
                return cell
            case 1:
                let cell = table.dequeueReusableCell(withIdentifier: "tallCell", for: indexPath) as! TallTableViewCell
                cell.setCells(at: indexPath)
                return cell
                
            case 2:
                let cell = table.dequeueReusableCell(withIdentifier: "ageCell", for: indexPath) as! AgeTableViewCell
                cell.setCells(at: indexPath)
                return cell
            default:
                return UITableViewCell()
            }
            
            
        case 2:
            switch indexPath.row {
            case 0:
                let cell = table.dequeueReusableCell(withIdentifier: "tagInputCell", for: indexPath) as! TagInputTableViewCell
                return cell
                
            default:
                let cell = table.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as! TagTableViewCell
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int{
        return CodeDef.sectionTitle.count
    }
    // Sectionのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CodeDef.sectionTitle[section] as? String
    }
    
    // Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return CodeDef.itemsArray.count
        case 1:
            return 3
        case 2:
            return 1//TagsModel.sharedInstance.tags.count + 1
        default:
            return 0
        }
    }
    
    
}

extension SearchConditionIchiranViewController: UIPickerViewDelegate,UIToolbarDelegate,UIPickerViewDataSource {
    
    
    /* プルダウン選択時 */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("pickerView")
        if (pickerView.tag == 1) {
            selectedTall = CodeDef.tallPickerDataSource[row]
        } else if (pickerView.tag == 2) {
            selectedAge = CodeDef.agePickerDataSource[row]
        }
    }
    
    /* プルダウンの要素 */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        //        if (component == 1) {
        //            return "〜"
        //        }
        if (pickerView.tag == 1) {
            let tall = CodeDef.tallPickerDataSource[row]
            return "\(tall[0])〜\(tall[1])cm"
            
            
            
            
        } else if (pickerView.tag == 2) {
            let age = CodeDef.agePickerDataSource[row]
            return "\(age[0])〜\(age[1])歳"
            
        } else {
            return "何らかのエラーにより取得できてません。"
        }
        
    }
    
    // DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    /* プルダウンの要素数 */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (pickerView.tag == 1) {
            return CodeDef.tallPickerDataSource.count
        } else if (pickerView.tag == 2) {
            return CodeDef.agePickerDataSource.count
        } else {
            return 0
        }
    }
}
