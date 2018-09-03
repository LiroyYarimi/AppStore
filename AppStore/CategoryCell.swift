//
//  CategoryCell.swift
//  AppStore
//
//  Created by liroy yarimi on 2.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{

    private let cellId = "appCellId"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let appCollectionView : UICollectionView = { // create new collection view inside our cell
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // horizontal scrolling
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = UIColor.black
        
        addSubview(appCollectionView)
        
        appCollectionView.dataSource = self
        appCollectionView.delegate = self
        
        appCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)//AppCell class is our cell
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":appCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":appCollectionView]))
    
        
    }
    
    //numberOfItemsInSection - 5 item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //sizeForItemAt - cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height)
    }
    
    //create cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
}

class AppCell: UICollectionViewCell { //the inside cell (app cell)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.red
    }
}

