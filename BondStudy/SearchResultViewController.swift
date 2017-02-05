//
//  SearchResultViewController.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/04.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit

class SearchResultViewController: UITableViewController {

    var vc: SearchBrandViewController?
    var key:String = ""
    //検索結果配列
    var searchResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "BrandsTableViewCell", bundle: nil)
        tableView.register(nib,forCellReuseIdentifier: "brandCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //データの個数を返すメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return BrandsModel.sharedInstance.dataList2.count
        return searchResults.count
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //データを返すメソッド
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //セルを取得する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath) as! BrandsTableViewCell
        cell.selectionStyle = .none
        cell.key = vc!.key
        cell.setCells(at: indexPath, using: searchResults)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = tableView.cellForRow(at: indexPath) as! BrandsTableViewCell
        cell.changeCell(at: indexPath, using: searchResults)
    }
}

extension SearchResultViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    //検索文字列変更時の呼び出しメソッド
    func updateSearchResults(for
        searchController: UISearchController) {
        //検索文字列を含むデータを検索結果配列に格納する。
        searchResults = CodeDef.dataList.filter { data in
            return data.contains(searchController.searchBar.text!)
        }
        
        //テーブルビューを再読み込みする。
        tableView.reloadData()
    }
    
    func willPresentSearchController(_ searchController:UISearchController) {
        print("willPresentSearchController")
        //        vc?.testTableView.frame = CGRect(x:0,y:8,width:self.view.frame.size.width,height:self.view.frame.size.height)
        
    }
    func willDismissSearchController(_ searchController:UISearchController) {
        print("willDismissSearchController")
        vc?.tableView.reloadData()
    }

}
