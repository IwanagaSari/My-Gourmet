//
//  AllListViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/07/11.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class AllListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var allListTableView: UITableView!
    //let shopCollection = ShopCollection.sharedInstance
    let shopCollection = ShopCollection()
    let areaCollection = AreaCollection()
    
    var selectedname: String?
    var selectedarea: String?
    var selectedgenre: String?
    var selectedcomment: String?
    var selectedrate: String?
    var selectedhasgone: ShopHasGone?
    var selectedindexpath: Int?
    
    var selectedareanum: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        allListTableView.delegate = self
        allListTableView.dataSource = self
        
        self.allListTableView.reloadData()
        
        
        self.shopCollection.fetchShops()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "All List"
        //self.allListTableView.reloadData()
        self.navigationItem.rightBarButtonItem = editButtonItem
        //self.navigationItem.leftBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopCollection.shops.count
        //return 7
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "shopListCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopListCell", for: indexPath)
        let shop = self.shopCollection.shops[indexPath.row]
        cell.textLabel!.text = shop.name
        cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
       
        return cell
    }
    
    /// セル選択時（UITableViewDataSource optional）
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop = self.shopCollection.shops[indexPath.row]
        selectedname = shop.name
        selectedarea = shop.area
        selectedgenre = shop.genre
        selectedcomment = shop.comment
        selectedrate = shop.rate
        selectedhasgone = shop.hasgone
        selectedindexpath = indexPath.row
        //selectedareanum = areaCollection.areas.indexOf(selectedarea)
        
        
        performSegue(withIdentifier: "toShopPage2Segue", sender: IndexPath.self)
        //self.shopCollection.shops[indexPath.row]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let shopPage2ViewController = segue.destination as!ShopPage2ViewController
        shopPage2ViewController.shopname2 = selectedname
        shopPage2ViewController.shoparea2 = selectedarea
        shopPage2ViewController.shopgenre2 = selectedgenre
        shopPage2ViewController.shopcomment2 = selectedcomment
        shopPage2ViewController.shoprate2 = selectedrate        
        shopPage2ViewController.shophasgone2 =  selectedhasgone
        shopPage2ViewController.indexpath2 = selectedindexpath
        //shopPage2ViewController.shopareanum2 = selectedareanum
        
        
    }
    
    
    //削除機能の実装
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.shopCollection.shops.remove(at: indexPath.row)
            self.shopCollection.save()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
            return
        default:
            return
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
