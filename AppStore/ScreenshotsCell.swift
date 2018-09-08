//
//  ScreenshotsCell.swift
//  AppStore
//
//  Created by liroy yarimi on 7.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell ,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var app : App? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let cellId = "cellId"
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
        addSubview(collectionView)
        addSubview(dividerLineView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["collectionView":collectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[dividerLineView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["dividerLineView":dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView][dividerLineView(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["collectionView":collectionView,"dividerLineView":dividerLineView]))

        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = app?.screenshots?.count {
            return count
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        
        if let imageName = app?.screenshots?[indexPath.item]{
            cell.imageView.image = UIImage(named: imageName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    private class ScreenshotImageCell : BaseCell{
        
        let imageView : UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleToFill
            iv.backgroundColor = UIColor.green
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        override func setupViews() {
            super .setupViews()
            
            layer.masksToBounds = true
            
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["imageView":imageView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["imageView":imageView]))
            
        }
    }
}
