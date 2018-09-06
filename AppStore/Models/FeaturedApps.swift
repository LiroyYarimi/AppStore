//
//  FeaturedApps.swift
//  AppStore
//
//  Created by liroy yarimi on 3.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class FeaturedApps : NSObject {
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories"{
            
            var appCategories = [AppCategory]()
            for dict in value as! [[String : AnyObject]] {
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories.append(appCategory)
            }
            self.appCategories = appCategories
        }else if key == "bannerCategory"{
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String:AnyObject])
        }else{
            super.setValue(value, forKey: key)
        }
    }
}






