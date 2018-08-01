//
//  ShopRegistrationViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/07/12.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class ShopRegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var shopNameText: UITextField!
    @IBOutlet weak var shopAreaText: UITextField!
    @IBOutlet weak var shopGenreText: UITextField!
    @IBOutlet weak var shopCommentText: UITextView!
    @IBOutlet weak var shopRateText: UITextField!
    @IBOutlet weak var shopHasGone: UISegmentedControl!
    
    let shopCollection = ShopCollection()
    let allListViewController = AllListViewController()
    //let shopPageViewController = ShopPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView.contentSize = CGSize(width: 470, height: 160)
        let imageButton = UIButton()
        imageButton.frame = CGRect(x: 5, y: 5, width: 150, height: 150)
        imageButton.setBackgroundImage(UIImage(named: "checkedbox.png"), for: UIControlState.normal)
        imageButton.clipsToBounds = true
        imageScrollView.addSubview(imageButton)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShopRegistrationViewController.tapGesture(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
        
        shopNameText.delegate = self
        shopRateText.delegate = self
        
        shopCommentText.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        shopCommentText.layer.borderWidth = 1
        shopCommentText.layer.cornerRadius = 5
        
        //allListViewController.allListTableView.reloadData()
        //self.shopCollection.fetchShops()
        


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "New Gourmet"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registration(_ sender: UIButton) {
        if shopNameText.text!.isEmpty {
            //お店の名前が入力されてなかったらアラートを出す
            let alertView = UIAlertController(title: "エラー", message:"お店の名前を入力して下さい", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        
        }else{
        self.performSegue(withIdentifier: "ShopPageSegue", sender: nil)
        //let shop = Shop()
        //shop.name = shopNameText.text!
        //shop.area = shopAreaText.text!
        //shop.genre = shopGenreText.text!
        //shop.comment = shopCommentText.text!
        //shop.rate = shopRateText.text!
        //shop.hasgone = ShopHasGone(rawValue: shopHasGone.selectedSegmentIndex)!
        //self.shopCollection.addShopCollection(shop: shop)
        //print(self.shopCollection.shops)
        
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        shopNameText.resignFirstResponder()
        shopCommentText.resignFirstResponder()
        shopAreaText.resignFirstResponder()
        shopGenreText.resignFirstResponder()
        shopRateText.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //実行したい処理
        shopNameText.resignFirstResponder()
        shopCommentText.resignFirstResponder()
        shopRateText.resignFirstResponder()
        shopAreaText.resignFirstResponder()
        shopGenreText.resignFirstResponder()
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shopPageViewController = segue.destination as!ShopPageViewController
        shopPageViewController.shopname = shopNameText.text
        shopPageViewController.shoparea = shopAreaText.text
        shopPageViewController.shopgenre = shopGenreText.text
        shopPageViewController.shopcomment = shopCommentText.text
        shopPageViewController.shoprate = shopRateText.text
        shopPageViewController.shophasgone =  shopHasGone.selectedSegmentIndex
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
