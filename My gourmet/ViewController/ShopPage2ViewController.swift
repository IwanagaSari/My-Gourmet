//
//  ShopPage2ViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/08/01.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class ShopPage2ViewController: UIViewController {

    @IBOutlet weak var shopName2: UILabel!
    @IBOutlet weak var shopArea2: UILabel!
    @IBOutlet weak var shopGenre2: UILabel!
    @IBOutlet weak var shopComment2: UITextView!
    @IBOutlet weak var rate2: UILabel!
    @IBOutlet weak var hasGoneLabel2: UILabel!
    
    let areaCollection = AreaCollection()
    let genreCollection = GenreCollection()
    
    var shopname2: String?
    var shoparea2: String?
    var shopgenre2: String?
    var shopcomment2: String?
    var shoprate2: String?
    var shophasgone2: ShopHasGone?
    var indexpath2: Int?
    var shopareanum2: Int?
    var shopgenrenum2: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopName2.text = shopname2
        shopArea2.text = shoparea2
        shopGenre2.text = shopgenre2
        shopComment2.text = shopcomment2
        rate2.text = shoprate2
        
        switch shophasgone2{
        case .hasgone? :
            hasGoneLabel2.text = "行ったことあり！"
        case .hasnotgone?:
            hasGoneLabel2.text = "行ったことなし！"
        default: break
        }
        
        shopComment2.layer.cornerRadius = 5
        shopComment2.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        shopComment2.layer.borderWidth = 1
        
        self.areaCollection.fetchAreas()
        shopareanum2 = areaCollection.areas.index(of: shoparea2! )
        shopgenrenum2 = genreCollection.genres.index(of: shopgenre2! )
        print(shopareanum2!)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "編集する", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ShopPage2ViewController.shopEditViewController(sender:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func shopEditViewController(sender:UIBarButtonItem) {
        self.performSegue(withIdentifier: "shopEditSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shopEditSegue"{
            let shopRegistrationViewController = segue.destination as!ShopRegistrationViewController
            shopRegistrationViewController.shopname = shopName2.text
            shopRegistrationViewController.shoparea = shopArea2.text
            shopRegistrationViewController.shopgenre = shopGenre2.text
            shopRegistrationViewController.shopcomment = shopComment2.text
            shopRegistrationViewController.shoprate = rate2.text
            shopRegistrationViewController.shophasgone = shophasgone2
            shopRegistrationViewController.indexPath = indexpath2
            shopRegistrationViewController.areanum = shopareanum2
            shopRegistrationViewController.genrenum = shopgenrenum2
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
