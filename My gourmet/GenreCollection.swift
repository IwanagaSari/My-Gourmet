//
//  GenreCollection.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/08/10.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class GenreCollection: NSObject {
    static let sharedInstance = GenreCollection()
    var genres:[String] = ["焼き鳥","焼肉","寿司"]
    
    //ーーーーーーーーーまず各画面のviewDidLoadで読み込まれ、保存したデータを呼び出すーーーーーーーーーーーーーーーーーーー
    func fetchAreas() {
        let defaults = UserDefaults.standard
        if let genreList = defaults.object(forKey: "genreLists") as? Array<String>{
            for genreDic in genreList{
                self.genres.append(genreDic)
            }
        }
    }
    
    //ーーーーー登録時など、新たにデータを保存するときに呼び出されるーーーーーーーーーーーーーーーーーー
    func addGenreCollection(genre: String){
        self.genres.append(genre)
        self.save()
    }
    
    func save() {
        var genreList: Array<String> = []
        
        for genre in genres{
            //let areaDic = AreaCollection.convertDictionary(shop: shop)
            genreList.append(genre)
        }
        let defaults = UserDefaults.standard
        defaults.set(genreList, forKey: "genreLists")
        defaults.synchronize()
    }
    

}
