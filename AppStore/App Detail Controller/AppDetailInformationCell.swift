//
//  AppDetailInformationCell.swift
//  AppStore
//
//  Created by liroy yarimi on 17.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class AppDetailInformationCell: BaseCell {
    let textView : UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE Information"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[textView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["textView":textView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[textView]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["textView":textView]))
    }
}
