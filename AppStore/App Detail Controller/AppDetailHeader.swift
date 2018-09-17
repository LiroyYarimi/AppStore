//
//  AppDetailHeader.swift
//  AppStore
//
//  Created by liroy yarimi on 17.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class AppDetailHeader: BaseCell {
    
    var app:App?{
        didSet{
            if let imageName = app?.imageName{
                imageView.image = UIImage(named: imageName)
            }
            nameLabel.text = app?.name
            if let price = app?.price?.stringValue{
                buyButton.setTitle("$"+price, for: .normal)
            }
        }
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details","Reviews","Related"])
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0 //Details will be selected
        sc.translatesAutoresizingMaskIntoConstraints = false
        
        return sc
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buyButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Free", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(segmentedControl)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerLineView)
        
        //is not work..
        //        addConstraintsWithFormat(format: "H:|-14-[v0(100)]|", views: imageView)
        //        addConstraintsWithFormat(format: "V:|-14-[v0(100)]|", views: imageView)
        //        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControl)
        //        addConstraintsWithFormat(format: "V:|[v0(34)]-8-|", views: segmentedControl)
        
        
        //the warning is about the size of the imageView (100)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["line":dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0(100)]-8-[v1][buy(60)]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView,"v1":nameLabel,"buy":buyButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[v0]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":segmentedControl]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[label(20)][buy(32)]-56-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["label":nameLabel,"buy":buyButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[imageView(100)]-10-[sc(34)]-8-[line(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["sc":segmentedControl,"imageView":imageView,"line":dividerLineView]))
        
    }
}
