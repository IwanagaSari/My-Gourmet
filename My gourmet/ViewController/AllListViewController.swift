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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allListTableView.delegate = self
        allListTableView.dataSource = self
        
        self.allListTableView.reloadData()
        self.shopCollection.fetchShops()
        
        
        //print(self.shopCollection.shops)
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
