//
//  AlamofireViewController.swift
//  BondStudy
//
//  Created by DaichiSaito on 2017/02/01.
//  Copyright © 2017年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
import AlamofireImage
class AlamofireViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let alamofireViewModel = AlamofireViewModel()
    var nails = ObservableArray<Nail>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nails = alamofireViewModel.nails
        alamofireViewModel.request()
        
        nails.bind(to: collectionView) { dataSource, indexPath, collectionView in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nailCell", for: indexPath) as! AlamofireCollectionViewCell
            let nail:Nail = self.nails[indexPath.row]
//            feed.title
//                .bind(to: cell.title.reactive.text)
//                .disposeIn(cell.reactive.bag)
//            feed.username
//                .map{ "@" + $0! }
//                .bind(to: cell.username.reactive.text)
//                .dispose(in: cell.reactive.bag)
//            feed.userImage
//                .bind(to: cell.userImageView.reactive.image)
//                .disposeIn(cell.reactive.bag)
//            
//            feed.fetchImageIfNeeded()
            cell.imageView.af_setImage(withURL: URL(string: nail.profile_image_url)!)
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

}
