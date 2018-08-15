//
//  AreaCollection.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/08/09.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class AreaCollection: NSObject {
    static let sharedInstance = AreaCollection()
    var areas:[String] = []
    
    //ーーーーーーーーーまず各画面のviewDidLoadで読み込まれ、保存したデータを呼び出すーーーーーーーーーーーーーーーーーーー
    func fetchAreas() {
        let defaults = UserDefaults.standard
        if let areaList = defaults.object(forKey: "areaLists") as? Array<String>{
            for areaDic in areaList{
                //let area = AreaCollection.convertAreaModel(attiributes: areaDic)
                self.areas.append(areaDic)
            }
        }
    }
    
    
   // class func convertAreaModel(attiributes: Array<String>) -> String {
       // let areaCollection = AreaCollection()
       // shop.name = attiributes["name"] as! String
        
       // shop.hasgone = ShopHasGone(rawValue: attiributes["hasgone"] as! Int)!
        
        //return shop
   // }
    //ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    
    //ーーーーー登録時など、新たにデータを保存するときに呼び出されるーーーーーーーーーーーーーーーーーー
    func addAreaCollection(area: String){
        self.areas.append(area)
        self.save()
    }
    
    //func changeShopCollection(shop: Shop, num: Int){
     //   self.shops[num] = shop
     //   self.save()
    //}
    
    func save() {
        var areaList: Array<String> = []
        
        for area in areas{
            //let areaDic = AreaCollection.convertDictionary(shop: shop)
            areaList.append(area)
        }
        let defaults = UserDefaults.standard
        defaults.set(areaList, forKey: "areaLists")
        defaults.synchronize()
    }
    
    
    //ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    
    

}
