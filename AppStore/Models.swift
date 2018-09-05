//
//  Models.swift
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


class AppCategory : NSObject{
    
    var name : String?
    var apps: [App]?
    var type: String?
    
    
    //override setValue func - for set value of our properties
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps"{
            
            apps = [App]()
            for dict in value as! [[String:AnyObject]]{
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
        }else if key == "name"{
            self.name = value as! String?
        }else if key == "type"{
            self.type = value as! String?
        }else{
            super.setValue(value, forKey: key)
        }
    
}
    
    //JSON request (without parameters) for all app details
    static func fetchFeaturedApps(completionHandler: @escaping (FeaturedApps) -> ()){
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"

        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            do{

                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String:AnyObject]
                
                let featuredApp = FeaturedApps()
                featuredApp.setValuesForKeys(json)//as! [String: AnyObject])
                
//                var appCategories = [AppCategory]()
//
//                for dict in json["categories"] as! [[String:AnyObject]]{
//
//                    let appCategory = AppCategory()
//                    appCategory.setValuesForKeys(dict)
//                    appCategories.append(appCategory)
//                }
                
                //send appCategories to FeaturedAppController class
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(featuredApp)
                })
                
                
                
            }catch let err{
                print(err)
            }
        }.resume()
        
    }
}


class App : NSObject{
    
    var id: NSNumber?
    var name: String?
    var category : String?
    var imageName: String?
    var price : NSNumber?
    
    override init() {
        return
    }
    
    init(id:NSNumber?, name: String,category:String, imageName:String, price: NSNumber) {
        self.id = id
        self.name = name
        self.category = category
        self.imageName = imageName
        self.price = price
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
        }else{
            super.setValue(value, forKey: key)
        }
        
    }
    
}
