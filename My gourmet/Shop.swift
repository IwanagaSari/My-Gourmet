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

class Shop: NSObject {
    var name = ""
    var area = ""
    var genre = ""
    var comment = ""
    var rate = ""
    var hasgone:ShopHasGone = .hasgone
}
