//
//  SearchResultViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/08/28.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var SearchResultTableView: UITableView!
    
    @IBOutlet weak var researchGenre: UILabel!
    @IBOutlet weak var researchArea: UILabel!
    
    let shopCollection = ShopCollection()
    //let areaCollection = AreaCollection()
    //let genreCollection = GenreCollection()
    
    var searchShops:[Shop] = []
    
    var selectedname: String?
    var selectedarea: String?
    var selectedgenre: String?
    var selectedcomment: String?
    var selectedrate: String?
    var selectedhasgone: ShopHasGone?
    var selectedindexpath: Int?
    
    var selectareas:[String] = []
    var selectgenres:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchResultTableView.delegate = self
        SearchResultTableView.dataSource = self
        
        for searchShop in searchShops {
            print(searchShop.name)
        }
        
        var text1:String? = ""
        for selectGenres in selectgenres{
            text1 = text1! + "\(selectGenres)/"
        }
        researchGenre.text = text1
        
        var text2:String? = ""
        for selectAreas in selectareas{
            text2 = text2! + "\(selectAreas)/"
        }
        researchArea.text = text2
        
        //self.shopCollection.fetchShops()
       // self.SearchResultTableView.reloadData()
        //self.genreCollection.fetchAreas()
        //self.shopCollection.fetchShops()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchShops.count
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reseachShopListCell", for: indexPath)
    let searchShop = searchShops[indexPath.row]
        
    cell.textLabel!.text = searchShop.name
        
    cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
        
    return cell
    }
    
    //セル選択時
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchShop = searchShops[indexPath.row]
        
        selectedname = searchShop.name
        selectedarea = searchShop.area
        selectedgenre = searchShop.genre
        selectedcomment = searchShop.comment
        selectedrate = searchShop.rate
        selectedhasgone = searchShop.hasgone
        selectedindexpath = indexPath.row
        
     performSegue(withIdentifier: "fromSearchResultToShopPage2Segue", sender: IndexPath.self)
        
    }
    
    //ShopPage2へ値の受け渡し
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
