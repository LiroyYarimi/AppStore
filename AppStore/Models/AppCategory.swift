//
//  AppCategory.swift
//  AppStore
//
//  Created by liroy yarimi on 6.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

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
