//
//  FeaturedAppController.swift
//  AppStore
//
//  Created by liroy yarimi on 2.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class FeaturedAppController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    var appCategories : [AppCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()

        AppCategory.fetchFeaturedApps { (appCategories) in //gets appCategories (from server) and show it
            self.appCategories = appCategories
            self.collectionView?.reloadData()
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //cellForItemAt - create cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        
        return cell
    }
    //numberOfItemsInSection - number of items
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count{
            return count
        }else{
            return 0
        }
    }
    
    //sizeForItemAt - cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }

}


