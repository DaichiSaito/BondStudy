//
//  ConditionIchiranViewController.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/02.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
import SwiftyJSON
class ConditionIchiranViewController: UIViewController {
    
    @IBAction func resetButton(_ sender: Any) {
        
        viewModel.getCondition()
//        UserDefaults.standard.removeObject(forKey: "CONDITION")
    }
    @IBAction func decideButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let value: [String: Any] = [
            "tops": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ],
            "pants": [
                "colors":["1","2","3"],
                "brands":["ナイキ","アディダス","プーマ"]
            ]
        ]
        
        let value2: [String: Any] = [
//            "season":["1","2","3"],
            "item":[
                "season":["1","2","3"],
                "tops": [
                    "colors":["1","2","3"],
                    "brands":["ナイキ","アディダス","プーマ"],
                    "title":"トップス"
                ],
                "pants": [
                    "colors":["1","2","3"],
                    "brands":["ナイキ","アディダス","プーマ"],
                    "title":"パンツ"
                ],
                "outer": [
                    "colors":["1","2","3"],
                    "brands":["ナイキ","アディダス","プーマ"],
                    "title":"アウター"
                ],
                "shose": [
                    "colors":["1","2","3"],
                    "brands":["ナイキ","アディダス","プーマ"],
                    "title":"シューズ"
                ],
                "hat": [
                    "colors":["1","2","3"],
                    "brands":["ナイキ","アディダス","プーマ"],
                    "title":"ハット"
                ],
                "neck": [
                    "colors":["1","2","3"],
                    "brands":["ナイキ","アディダス","プーマ"],
                    "title":"ネック"
                ]
            ],
            "tag":["タグ1","タグ2","タグ3"]
            ]
//        print(viewModel.conditions.array)
        var array = [Dictionary<String, Any>]()
        var dic: [String: Any]?
        var a = self.conditions[0]
//        a.colors = ObservableArray(["2","2","2"])
        a.test = Observable("kakikukeko")
//        self.conditions[0]
//        self.conditions[0] = a as! Condition
//        self.conditions.replace(with: self.conditions)
        for condition in viewModel.conditions.array {
//            print(condition)
//            print(condition.key)
//            print(condition.key as! String)
            let tmpKey:String = condition.key
            let tmpDic = [
                tmpKey: [
                    "colors" : condition.colors,
                    "brands" : condition.brands
                ]
            ]
            array.append(tmpDic)
//            array.append(
//                tmpKey: [
//                    "colors" : condition.colors,
//                    "brands" : condition.brands
//                ]
//            )
            
        }
        dic = [
        "item": array
        ]
//        let a = JSON(viewModel.conditions.array)
        userDefaults.set(value2, forKey:"CONDITION")
//        userDefaults.set(dic, forKey:"CONDITION2")
    }

    @IBOutlet weak var tableView: UITableView!
    let viewModel = ConditionViewModel()
    var conditions = ObservableArray<Condition>()
    @IBAction func cancelButton(_ sender: Any) {
        // 閉じる
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        viewModel.getCondition()
        // Do any additional setup after loading the view.
        self.conditions = viewModel.conditions
//        viewModel.request2()
        
        conditions.bind(to: tableView) { dataSource, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ConditionTableViewCell
            let condition:Condition = dataSource[indexPath.row]
            condition.test
                .bind(to: cell.itemName.reactive.text)
                .dispose(in: cell.reactive.bag)
            condition.colors.observeNext { value in
                print("Hi \(value)!")
            }.dispose(in: cell.reactive.bag)
            condition.colors.map {_ in 
                print("a")
            }
//            condition.test.map{ $0.characters.count }.bind(to: cell.itemName.reactive.text).dispose(in: cell.reactive.bag)
            
//            feed.username
//                .map{ "@" + $0! }
//                .bind(to: cell.username.reactive.text)
//                .dispose(in: cell.reactive.bag)
//            feed.userImage
//                .bind(to: cell.userImageView.reactive.image)
//                .disposeIn(cell.reactive.bag)
//            
//            feed.fetchImageIfNeeded()
//            cell.brandName.text
//            cell.setCell(condition: condition, indexPath: indexPath)
            return cell
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toSecondViewController" {
//            let secondViewController = segue.destination as! SecondViewController
//            secondViewController.parameters = sender as! [String : String]
//        }
//    }

    
}

extension ConditionIchiranViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let condition:Condition = conditions[indexPath.row]
        let controller = self.storyboard!.instantiateViewController( withIdentifier: "colorAndBrandViewController" ) as! ColorAndBrandViewController
        controller.condition = condition
        self.navigationController?.pushViewController(controller, animated: true)
//        if let url = feed.url {
//            let safariVC = SFSafariViewController(url: url as URL)
//            self.navigationController?.show(safariVC, sender: nil)
//        }
    }
}
