//
//  AppDetailDescriptionCell.swift
//  AppStore
//
//  Created by liroy yarimi on 17.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class AppDetailDescriptionCell: BaseCell {
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(dividerLineView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[textView]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["textView":textView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[dividerLineView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["dividerLineView":dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[textView]-4-[dividerLineView(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["textView":textView,"dividerLineView":dividerLineView]))
    }
}
