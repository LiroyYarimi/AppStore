//
//  AppCell.swift
//  AppStore
//
//  Created by liroy yarimi on 6.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class AppCell: BaseCell { //the inside cell (app cell)
    
    var app: App?{
        didSet{
            if let name = app?.name {
                nameLabel.text = name
                
                //all this for make the spaces fit for one line and two lines.
                let rect = NSString(string: name).boundingRect(with: CGSize(width: frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if rect.height > 20{ //two lines
                    categoryLabel.frame = CGRect(x: 0, y: frame.width+38, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width+56, width: frame.width, height: 20)
                }else{//one line
                    categoryLabel.frame = CGRect(x: 0, y: frame.width+22, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width+40, width: frame.width, height: 20)
                }
                nameLabel.frame = CGRect(x: 0, y: frame.width+5, width: frame.width, height: 40)
                nameLabel.sizeToFit()
                
            }
            categoryLabel.text = app?.category
            if let price = app?.price{
                priceLabel.text = "$\(price)"
            }else{
                priceLabel.text = ""
            }
            if let imageName = app?.imageName{
                imageView.image = UIImage(named: imageName)
            }
            
            
        }
    }
    
    
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        //iv.image = UIImage(named: "frozen")
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
    
    override func setupViews() {//app cell view
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
