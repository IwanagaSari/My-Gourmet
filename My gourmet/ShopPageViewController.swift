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
    
    
    
    let shopRegistration = ShopRegistrationViewController()
    //let shop = Shop()
    var shopname: String?
    var shoparea: String?
    var shopgenre: String?
    var shopcomment: String?
    var shoprate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopName.text = shopname
        shopArea.text = shoparea
        shopGenre.text = shopgenre
        ShopComment.text = shopcomment
        rate.text = shoprate
        
        
        

        // Do any additional setup after loading the view.
        //shopName.text = shopRegistration.shopNameText.text!
        //ShopComment.text = shopRegistration.shopCommentText.text!
        //rate.text = shopRegistration.shopRateText.text!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ShopPageViewController.close(sender:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "編集へ戻る", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ShopPageViewController.edit(sender:)))
    }
    
    //func pageview(shop: Shop){
      //  shopName.text = shop.name
     //  print("sari")
    //}
    
    @objc func close(sender: UIBarButtonItem) {
        //self.performSegue(withIdentifier: "shopRegistrationSegue", sender: nil)
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
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
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
