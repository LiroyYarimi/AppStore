//
//  AppDetailController.swift
//  AppStore
//
//  Created by liroy yarimi on 6.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

//this class is the detail of each app
class AppDetailController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var app: App?{
        didSet{
            
            if app?.screenshots != nil{ //screenshots was change? empty return to avoid a infinity loop - because of this line self.app = appDetail
                return
            }
//            navigationItem.title = app?.name //change the title name
            if let id = app?.id{
                let urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
                
                URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    do{
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String:AnyObject]
                        let appDetail = App()
                        appDetail.setValuesForKeys(json)
                        self.app = appDetail
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.collectionView?.reloadData()
                        })
                    }catch let err{
                        print(err)
                    }
                    }.resume()
            }
        }
    }
    
    private let headerId = "headerId"
    private let cellId = "cellId"
    private let descriptionCellId = "descriptionCellId"
    private let informationCellId = "informationCellId"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
        collectionView?.register(AppDetailInformationCell.self, forCellWithReuseIdentifier: informationCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellId, for: indexPath) as! AppDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        }
        
        if indexPath.item == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: informationCellId, for: indexPath) as! AppDetailInformationCell
            cell.textView.attributedText = informationAttributedText()
            return cell
        }
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotsCell
        cell.app = app
        return cell
    }
    
    private func descriptionAttributedText() -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(kCTParagraphStyleAttributeName as NSAttributedStringKey, value: style, range: range)
        
        if let desc = app?.desc{
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11), NSAttributedStringKey.foregroundColor : UIColor.darkGray]))
            
        }
        
        return attributedText
    }
    
    private func informationAttributedText() -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "Information\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
//        style.alignment = .right
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(kCTParagraphStyleAttributeName as NSAttributedStringKey, value: style, range: range)
        
        if let info = app?.appInformation{
            for obje in info {
                var name = obje.name!
                if name == "Size"{ //fix the spaces
                    name = obje.name! + "\t\t\t"
                }else if name == "Family Sharing" || name == "Compatibility"{
                    name = obje.name! + "\t"
                }else{
                    name = obje.name! + "\t\t"
                }
                let value = obje.value! + "\n"
                
                attributedText.append(NSAttributedString(string: name, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11), NSAttributedStringKey.foregroundColor : UIColor.gray ]))
                attributedText.append(NSAttributedString(string: value, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11), NSAttributedStringKey.foregroundColor : UIColor.darkGray]))
            }
        }
        return attributedText
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1{//description cell
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30) //colcolate the text height
        }
//        else if indexPath.item == 2{//info cell
//            return CGSize(width: view.frame.width/2, height: 170)
//        }
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath )as! AppDetailHeader
        header.app = app
        return header
    }
    
    //referenceSizeForHeaderInSection - size of the header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout :UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: view.frame.width, height: 170)
    }
    
}










extension UIView{ //is not work..
    
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
