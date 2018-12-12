//
//  ShopPageViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/07/20.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class ShopPageViewController: UIViewController {
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopArea: UILabel!
    @IBOutlet weak var shopGenre: UILabel!
    @IBOutlet weak var ShopComment: UITextView!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var hasGoneLabel: UILabel!
    
    
    
    let shop = Shop()
    let area = AreaCollection()
    let shopRegistration = ShopRegistrationViewController()
    let shopCollection = ShopCollection()
    
    var shopname: String?
    var shoparea: String?
    var shopgenre: String?
    var shopcomment: String?
    var shoprate: String?
    var shophasgone: Int?
    var indexpath: Int?
    var shopareanum : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(shopareanum!)
        
        shopName.text = shopname
        shopArea.text = shoparea
        shopGenre.text = shopgenre
        ShopComment.text = shopcomment
        rate.text = shoprate
        
        switch shophasgone {
            case 0:
                hasGoneLabel.text = "行ったことあり！"
            case 1:
                 hasGoneLabel.text = "行ったことない"
            default: break
        }
        
        ShopComment.layer.cornerRadius = 5
        ShopComment.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        ShopComment.layer.borderWidth = 1
        
        self.shopCollection.fetchShops()
        
        let myURL = URL(string: "http://google.com")
        let myURLRequest = URLRequest(url: myURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "編集へ戻る", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ShopPageViewController.edit(sender:)))
    }
    
    @objc func edit(sender: UIBarButtonItem) {
        //self.performSegue(withIdentifier: "shopRegistrationSegue", sender: nil)
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finalRegistration(_ sender: UIButton) {
        shop.name = shopName.text!
        shop.area = shopArea.text!
        
        shop.genre = shopGenre.text!
        shop.comment = ShopComment.text!
        shop.rate = rate.text!
        
        switch shophasgone{
            case 0:
                shop.hasgone = .hasgone
            case 1:
                shop.hasgone = .hasnotgone
            default: break
        }
        //segumentは前のページで選択するので使えなかった↓
        //shop.hasgone = ShopHasGone(rawValue: shopHasGone.selectedSegmentIndex)!
        
        if let IndexPath = indexpath {
            self.shopCollection.changeShopCollection(shop: shop,num: IndexPath)
        }else{
            self.shopCollection.addShopCollection(shop: shop)
            print(self.shopCollection.shops)
        }
        performSegue(withIdentifier: "toTopPageSegue", sender: IndexPath.self)
    }
}
