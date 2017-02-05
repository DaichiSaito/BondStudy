//
//  SearchBrandViewController.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/04.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class SearchBrandViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    var key: String = ""
    var decideFlg: Bool = false
    var backupSelectedBrands:[String: Any]?
    //検索結果配列
    var searchResults = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.loadViewIfNeeded()
        //結果表示用のビューコントローラーをサーチコントローラーに設定する。
        let resultController = SearchResultViewController()
        resultController.vc = self
        searchController = UISearchController(searchResultsController: resultController)
        searchController.searchResultsUpdater = resultController
        searchController.delegate = resultController
        searchController.searchBar.showsScopeBar = false
        self.automaticallyAdjustsScrollViewInsets = false
//        searchController.searchBar.scopeButtonTitles = ["どれか含む", "全て含む"] //Scopeボタンのタイトルを設定
        tableView.dataSource = self
        tableView.delegate = self
        //        tableView.allowsMultipleSelection = true
        //テーブルビューのヘッダーにサーチバーを設定する。
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        let nib = UINib(nibName: "BrandsTableViewCell", bundle: nil)
        tableView.register(nib,forCellReuseIdentifier: "brandCell")
        
        backupSelectedBrands = ModelConditions.sharedInstance.get()
        

        let rightButtonItem:UIBarButtonItem = UIBarButtonItem(title: "決定", style:.plain, target: self, action: #selector(SearchBrandViewController.decide))
        self.navigationItem.setRightBarButtonItems([rightButtonItem], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func decide() {
        decideFlg = true
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if decideFlg {
            
        } else {
            // バックアップから戻す
            ModelConditions.sharedInstance.set(condition: backupSelectedBrands!)
        }
        super.viewWillDisappear(animated)
    }
    
}

extension SearchBrandViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = tableView.cellForRow(at: indexPath) as! BrandsTableViewCell
        cell.changeCell(at: indexPath, using: CodeDef.dataList)
    }
    
    
    
    
}
extension SearchBrandViewController: UITableViewDataSource {
    
    //データを返すメソッド
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        
        //セルを取得する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for:indexPath) as! BrandsTableViewCell
        cell.key = key
        cell.setCells(at: indexPath, using: CodeDef.dataList)
        return cell
    }

    //データの個数を返すメソッド
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        return CodeDef.dataList.count
    }
    
    
}
