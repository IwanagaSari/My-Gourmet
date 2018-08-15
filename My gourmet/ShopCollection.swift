//
//  ShopCollection.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/07/24.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class ShopCollection: NSObject {
    static let sharedInstance = ShopCollection()
    var shops:[Shop] = []
    
   
    //ーーーーーーーーーまず各画面のviewDidLoadで読み込まれ、保存したデータを呼び出すーーーーーーーーーーーーーーーーーーー
    func fetchShops() {
        let defaults = UserDefaults.standard
        if let shopList = defaults.object(forKey: "shopLists") as? Array<Dictionary<String, AnyObject>>{
            for shopDic in shopList{
                let shop = ShopCollection.convertShopModel(attiributes: shopDic)
                self.shops.append(shop)
            }
        }
    }
    
    
    class func convertShopModel(attiributes: Dictionary<String, AnyObject>) -> Shop {
        let shop = Shop()
        shop.name = attiributes["name"] as! String
        shop.area = attiributes["area"] as! String
        shop.genre = attiributes["genre"] as! String
        shop.comment = attiributes["comment"] as! String
        shop.rate = attiributes["rate"] as! String
        shop.hasgone = ShopHasGone(rawValue: attiributes["hasgone"] as! Int)!

        return shop
    }
    //ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    
    
    
    //ーーーーー登録時など、新たにデータを保存するときに呼び出されるーーーーーーーーーーーーーーーーーー
    func addShopCollection(shop: Shop){
        self.shops.append(shop)
        self.save()
    }
    
    func changeShopCollection(shop: Shop, num: Int){
        self.shops[num] = shop
        self.save()
    }
    
    func save() {
        var shopList: Array<Dictionary<String, AnyObject>> = []
        
        for shop in shops{
            let shopDic = ShopCollection.convertDictionary(shop: shop)
            shopList.append(shopDic)
        }
        let defaults = UserDefaults.standard
        defaults.set(shopList, forKey: "shopLists")
        defaults.synchronize()
    }
    
    class func convertDictionary(shop: Shop) -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["name"] = shop.name as AnyObject
        dic["area"] = shop.area as AnyObject
        dic["genre"] = shop.genre as AnyObject
        dic["comment"] = shop.comment as AnyObject
        dic["rate"] = shop.rate as AnyObject
        dic["hasgone"] = shop.hasgone.rawValue as AnyObject
        return dic
    }
    //ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    

}
