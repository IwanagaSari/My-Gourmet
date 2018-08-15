//
//  Shop.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/07/23.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

enum ShopHasGone: Int {
    case hasgone  = 0
    case hasnotgone = 1
}
var areas: NSArray = ["中洲", "天神", "春吉"]


class Shop: NSObject {
    var name = ""
    var area = ""
   // var areanum = 0
    var genre = ""
   // var genrenum = 0
    var comment = ""
    var rate = ""
    var hasgone:ShopHasGone = .hasgone
}
