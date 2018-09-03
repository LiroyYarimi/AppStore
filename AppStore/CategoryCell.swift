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
    
    //all the app cell is here. because we did that app cell will cover all the big cell (vertical cell) so we can't see the different. unless we write "H:|-8-[v0]-8-|"
    let appCollectionView : UICollectionView = { // create new collection view inside our cell
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // horizontal scrolling
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let dividerLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel :UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){ //apps container cell. the big vertical cell
        backgroundColor = UIColor.clear
        
        addSubview(appCollectionView) //inside each cell add app cell
        addSubview(dividerLineView)
        addSubview(nameLabel)
        
        appCollectionView.dataSource = self
        appCollectionView.delegate = self
        
        appCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)//AppCell class is our cell
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":appCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":appCollectionView,"v1":dividerLineView,"nameLabel":nameLabel]))
    
        
    }
    
    //numberOfItemsInSection - 5 item of app cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //sizeForItemAt - app cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 32)
    }
    
    //create cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    //insetForSectionAt - make some space between cell container app to the big cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
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
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "frozen")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16 //round corner
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel :UILabel = {
        let label = UILabel()
        label.text = "Disney Build It: Frozen"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {//app cell view
//        backgroundColor = UIColor.black
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width+2, width: frame.width, height: 40)
        categoryLabel.frame = CGRect(x: 0, y: frame.width+38, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width+56, width: frame.width, height: 20)
    }
}

