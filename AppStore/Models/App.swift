//
//  App.swift
//  AppStore
//
//  Created by liroy yarimi on 6.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class App : NSObject{
    
    var id: NSNumber?
    var name: String?
    var category : String?
    var imageName: String?
    var price : NSNumber?
    
    var screenshots : [String]?
    var desc : String?
    var appInformation : [Information]?
    
    override init() {
        return
    }
    
    init(id:NSNumber?, name: String,category:String, imageName:String, price: NSNumber, screenshots: [String]?,desc : String?, appInformation:[Information]?) {
        self.id = id
        self.name = name
        self.category = category
        self.imageName = imageName
        self.price = price
        
        self.screenshots = screenshots
        self.desc = desc
        self.appInformation = appInformation
    }
    
    //override setValue func - for set value of our properties
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "Category"{
            self.category = value as! String?
        }else if key == "Name"{
            self.name = value as! String?
        }else if key == "Id"{
            self.id = value as! NSNumber?
        }else if key == "ImageName"{
            self.imageName = value as! String?
        }else if key == "Price"{
            self.price = value as! NSNumber?
        }else if key == "Screenshots"{
            self.screenshots = value as! [String]?
        }else if key == "description"{
            self.desc = value as? String
        }else if key == "appInformation"{
//            self.appInformation = value as AnyObject
            appInformation = [Information]()
            for dict in value as! [[String:AnyObject]]{
                let line = Information()
                line.setValuesForKeys(dict)
                appInformation?.append(line)
            }
        }else{
            super.setValue(value, forKey: key)
        }
        
    }
    
    class Information : NSObject{
        var name: String?
        var value : String?
        
        override func setValue(_ value: Any?, forKey key: String) {
            if key == "Name"{
                self.name = value as! String?
            }else if key == "Value"{
                self.value = value as! String?
            }else{
                super.setValue(value, forKey: key)
            }
        }
    }
    
}
