//
//  ViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/11/06.
//  Copyright © 2018 iwanaga sari. All rights reserved.
//

import UIKit

class TopViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var searchWayTableView: UITableView!
    
    //let shopCollection = ShopCollection()
    //let searchCollection = SearchCollection()
    var backView :UIView!
    var searchListView :UIView!
    var addAreaOrGerne :UITextField!
    var searchWayDetail1 :UITextField!
    var searchWayDetail2 :UITextField!
    var searchWayDetail3 :UITextField!
    var addView :UIView!
    var addDetail :UITextField!
    
    var selectedarea: String?
    var selectedareas:[String] = []
    
    var selectedgenre: String?
    var selectedgenres:[String] = []
    
    var Section2: String?
    var selectedhasgone: ShopHasGone?
    
    var shoplist:[Shop] = []
    var shoplist2:[Shop] = []
    
    let allListViewController = AllListViewController()
    let shopCollection = ShopCollection()
    let areaCollection = AreaCollection()
    let genreCollection = GenreCollection()
    let sectionTitle = ["エリア", "ジャンル", "行った・行ってない"]
    let section2 = ["行った","行ってない"]

    override func viewDidLoad() {
        super.viewDidLoad()
        searchWayTableView.delegate = self
        searchWayTableView.dataSource  = self
        
        
        // trueで複数選択、falseで単一選択
        searchWayTableView.allowsMultipleSelection = true
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopViewController.tapGesture(_:)))
        tapRecognizer.cancelsTouchesInView = false
        
        
        self.areaCollection.fetchAreas()
        self.genreCollection.fetchAreas()
        
        
        
        self.shopCollection.fetchShops()
        
        
        selectedarea = ""
        selectedgenre = ""
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "お店登録", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TopViewController.shopRegistrationViewController(sender:)))
        self.navigationController!.navigationBar.tintColor = UIColor.white
        //allListViewController.allListTableView.reloadData()
        
        //ハイライト解除
        searchWayTableView.reloadData()
        
        //self.areaCollection.fetchAreas()
        //self.genreCollection.fetchAreas()
        //self.shopCollection.fetchShops()
        
        selectedareas.removeAll()
        selectedgenres.removeAll()
        shoplist.removeAll()
        shoplist2.removeAll()
        print(selectedareas)
        print(selectedgenres)
        print(shoplist)
        print(shoplist2)
        
    }
    //ーーーーーーーーーーーーーーーセルの設定ーーーーーーーーーーーーーーーーー
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return self.areaCollection.areas.count
        case 1 :
            return self.genreCollection.genres.count
        case 2 :
            return self.section2.count
        default:
            return 0
        }
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(20)
    }
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.accessoryType = .none
        
        //let search = self.searchCollection.lists[indexPath.row]
        //cell.textLabel?.text = search.title
        //cell.textLabel?.font = UIFont(name: "HirakakuProN-W6", size: 15)
        switch indexPath.section {
        case 0 :
            cell.textLabel?.text = areaCollection.areas[indexPath.row]
        case 1 :
            cell.textLabel?.text = genreCollection.genres[indexPath.row]
        case 2 :
            cell.textLabel?.text = section2[indexPath.row]
        default : break
        }
        
        return cell
    }
    //セルの削除機能
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            
            switch indexPath.section {
            case 0 :
                self.areaCollection.areas.remove(at: indexPath.row)
                self.areaCollection.save()
                
            case 1 :
                self.genreCollection.genres.remove(at: indexPath.row)
                self.genreCollection.save()
                
            default : break
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if indexPath.section == 2{
            deleteButton.backgroundColor = UIColor.white
        }else{
            deleteButton.backgroundColor = UIColor.red
        }
        return [deleteButton]
    }
    //セルの削除機能の制限
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0 :
            return true
        case 1 :
            return true
        case 2 :
            return false
        default:
            return true
        }
    }
    //セルが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //チェックマークをつける
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .checkmark
        
        switch indexPath.section {
        case 0 :
            selectedarea = areaCollection.areas[indexPath.row]
            selectedareas.append(areaCollection.areas[indexPath.row])
            print(selectedareas)
            
        case 1 :
            selectedgenre = genreCollection.genres[indexPath.row]
            selectedgenres.append(genreCollection.genres[indexPath.row])
            print(selectedgenres)
            
        //let genre = genreCollection.genres[indexPath.row]
        case 2 :
            Section2  = section2[indexPath.row]
            print(Section2!)
        //let hasgone = section2[indexPath.row]
        default : break
        }
        
    }
    //同じセルが再度選択された時
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        // チェックマークを外す
        cell?.accessoryType = .none
        
        switch indexPath.section {
        case 0 :
            selectedarea = areaCollection.areas[indexPath.row]
            selectedareas = selectedareas.filter {$0 != selectedarea}
            
        case 1 :
            selectedgenre = genreCollection.genres[indexPath.row]
            selectedgenres = selectedgenres.filter {$0 != selectedgenre}
            
        default : break
        }
        //strArray.remove(at: strArray.index(of: "B")
    }
    //ーーーーーーーーーーーーーセクションーーーーーーーーーーーーーーー
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return self.searchCollection.lists.count
        return 3
    }
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    //セクションのタイトルの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    //--------------------キーボードを閉じる実装--------------------------------
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        
        addAreaOrGerne.resignFirstResponder()
        //addGenre.resignFirstResponder()
        //searchWayDetail1.resignFirstResponder()
        //searchWayDetail2.resignFirstResponder()
        //searchWayDetail3.resignFirstResponder()
        ///////addDetail.resignFirstResponder()
    }
    //-------------------returnを押したらキーボード閉じる------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addAreaOrGerne.resignFirstResponder()
        searchWayDetail1.resignFirstResponder()
        searchWayDetail2.resignFirstResponder()
        searchWayDetail3.resignFirstResponder()
        //addDetail.resignFirstResponder()
        return true
    }
    //ーーーーーーーーートップ画面の検索条件追加ボタンを押した時ーーーーーーーーーーーーーーーー
    @IBAction func addSearchList(_ sender: UIButton) {
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopViewController.tapGesture(_:)))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        //投稿画面後ろの黒い画面を作成
        let backView = makeBackView()
        self.view.addSubview(backView)
        
        searchListView = makeSearchListView()
        backView.addSubview(searchListView)
        
        addAreaOrGerne = makeAddAreaOrGnere()
        searchListView.addSubview(addAreaOrGerne)
        
        let searchWayLabel = makeLabel(text: "追加するエリア", x:10, y: 15)
        searchListView.addSubview(searchWayLabel)
        
        //エリア追加ボタン
        let createBtn = makeAddAreaBtn(x:130, y:170)
        searchListView.addSubview(createBtn)
        //キャンセルボタン
        let cancelBtn = makeCancelBtn(searchListView: searchListView)
        searchListView.addSubview(cancelBtn)
    }
    @IBAction func addGenreButton(_ sender: UIButton) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopViewController.tapGesture(_:)))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        //投稿画面後ろの黒い画面を作成
        let backView = makeBackView()
        self.view.addSubview(backView)
        //黒い画面上に白の画面を作成
        searchListView = makeSearchListView()
        backView.addSubview(searchListView)
        //ラベル
        let searchWayLabel = makeLabel(text: "追加するジャンル", x:10, y: 15)
        searchListView.addSubview(searchWayLabel)
        //入力欄
        addAreaOrGerne = makeAddAreaOrGnere()
        searchListView.addSubview(addAreaOrGerne)
        //作成！ボタン
        let createBtn = makeAddGenreBtn(x:130, y:170)
        searchListView.addSubview(createBtn)
        //キャンセルボタン
        let cancelBtn = makeCancelBtn(searchListView: searchListView)
        searchListView.addSubview(cancelBtn)
        
    }
    func makeBackView() -> UIView{
        backView = UIView()
        backView.frame = CGRect(x: 0, y: 0,  width: self.view.frame.width, height: self.view.frame.height)
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return backView
    }
    
    func makeSearchListView() -> UIView {
        let searchListView = UIView()
        searchListView.frame.size = CGSize(width: 350, height: 250)
        searchListView.center.x = self.view.center.x
        searchListView.center.y = 350
        searchListView.backgroundColor = UIColor.white
        searchListView.layer.shadowOpacity = 0.3
        searchListView.layer.cornerRadius = 3
        return searchListView
    }
    
    
    func makeAddAreaOrGnere() -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x:10, y:70, width:280, height:60)
        textField.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.placeholder = "エリア、シーン、etc..."
        return textField
    }
    func makeSearchWayDetail(placeholder: String, x: CGFloat ,y: CGFloat ) -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x:x, y: y, width:180, height:40)
        textField.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.placeholder = placeholder
        return textField
    }
    
    func makeLabel(text: String, x: CGFloat, y: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: x, y: y, width:280, height:40))
        label.text = text
        label.font = UIFont(name: "HiraKakuProN-W6", size: 25)
        return label
    }
    func makeAddSearchWayDetailBtn(searchListView: UIView) -> UIButton {
        let addBtn = UIButton()
        addBtn.frame = CGRect(x: 90, y: 230,width:25, height:25)
        addBtn.setBackgroundImage(UIImage(named: "plusButton.png"), for: .normal)
        addBtn.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        addBtn.layer.cornerRadius = addBtn.frame.width / 2
        addBtn.addTarget(self, action: #selector(self.tappedAddBtn(_:)), for:.touchUpInside)
        return addBtn
    }
    func makeAddAreaBtn(x: CGFloat, y: CGFloat) -> UIButton {
        let createBtn = UIButton()
        createBtn.frame = CGRect(x:x, y:y, width:100,height:50)
        createBtn.setTitle("エリア追加", for: .normal)
        createBtn.titleLabel?.font = UIFont(name: "HiraginoMaruGothicProN-W4", size: 15)
        createBtn.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        createBtn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        createBtn.layer.cornerRadius = 7
        createBtn.addTarget(self, action: #selector(self.tappedAreaSubmitBtn(_:)), for:.touchUpInside)
        return createBtn
    }
    func makeAddGenreBtn(x: CGFloat, y: CGFloat) -> UIButton {
        let createBtn = UIButton()
        createBtn.frame = CGRect(x:x, y:y, width:100,height:50)
        createBtn.setTitle("ジャンル追加", for: .normal)
        createBtn.titleLabel?.font = UIFont(name: "HiraginoMaruGothicProN-W4", size: 15)
        createBtn.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        createBtn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        createBtn.layer.cornerRadius = 7
        createBtn.addTarget(self, action: #selector(self.tappedGenreSubmitBtn(_:)), for:.touchUpInside)
        return createBtn
    }
    
    func makeCancelBtn(searchListView: UIView) -> UIButton{
        let cancelBtn = UIButton()
        cancelBtn.frame.size = CGSize(width:20, height:20)
        cancelBtn.center.x = searchListView.frame.width-15
        cancelBtn.center.y = 15
        cancelBtn.setBackgroundImage(UIImage(named: "cancel.png"), for: .normal)
        cancelBtn.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        cancelBtn.layer.cornerRadius = cancelBtn.frame.width / 2
        cancelBtn.addTarget(self, action: #selector(self.tappedCancelBtn(_:)), for:.touchUpInside)
        return cancelBtn
    }
    func makeBackBtn() -> UIButton{
        let backBtn = UIButton()
        backBtn.frame = CGRect(x:10, y:10,width:50, height:30)
        backBtn.setBackgroundImage(UIImage(named: "back.png"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.tappedBackBtn(_:)), for:.touchUpInside)
        return backBtn
    }
    func makeTopViewBottomBtn(setTitle: String, x: CGFloat, y:CGFloat) -> UIButton {
        let searchBtn = UIButton()
        searchBtn.setTitle(setTitle, for: .normal)
        searchBtn.frame = CGRect(x: x, y: y, width:100, height:50)
        searchBtn.titleLabel?.font = UIFont(name: "HiraginoMaruGothicProN-W4", size: 15)
        searchBtn.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        searchBtn.backgroundColor = UIColor.gray
        searchBtn.layer.cornerRadius = 7
        return searchBtn
    }
    //キャンセルボタンの実装
    @objc func tappedCancelBtn(_ seder: AnyObject){
        backView.removeFromSuperview()
    }
    //戻るボタンの実装
    @objc func tappedBackBtn(_ seder: AnyObject){
        print("戻る")
        addView.removeFromSuperview()
    }
    //エリア追加ボタンの実装
    @objc func tappedAreaSubmitBtn(_ sender :AnyObject){
        
        if  addAreaOrGerne.text != nil{
            self.areaCollection.addAreaCollection(area: addAreaOrGerne.text!)
            print("エリア：\(addAreaOrGerne.text!)")
        }
        self.searchWayTableView.reloadData()
        backView.removeFromSuperview()
    }
    //ジャンル追加ボタンの実装
    @objc func tappedGenreSubmitBtn(_ sender: AnyObject){
        
        if  addAreaOrGerne.text != nil {
            self.genreCollection.addGenreCollection(genre: addAreaOrGerne.text!)
            print("ジャンル：\(addAreaOrGerne.text!)")
        }
        self.searchWayTableView.reloadData()
        backView.removeFromSuperview()
        
    }
    //ーーーーーーーーーーー詳細追加ボタンを押した後の画面ーーーーーーーーーーーーーーーーーー
    @objc func tappedAddBtn(_ sender: AnyObject){
        addView = makeSearchListView()
        backView.addSubview(addView)
        
        addDetail = makeSearchWayDetail(placeholder:"", x:90, y:60)
        addView.addSubview(addDetail)
        addDetail = makeSearchWayDetail(placeholder:"", x:90, y:100)
        addView.addSubview(addDetail)
        addDetail = makeSearchWayDetail(placeholder:"", x:90, y:140)
        addView.addSubview(addDetail)
        let searchWayDetailLabel4 = makeLabel(text: "条件詳細", x: 10, y: 60)
        addView.addSubview(searchWayDetailLabel4)
        let searchWayDetailLabel5 = makeLabel(text: "条件詳細", x: 10, y: 100)
        addView.addSubview(searchWayDetailLabel5)
        let searchWayDetailLabel6 = makeLabel(text: "条件詳細", x: 10, y: 140)
        addView.addSubview(searchWayDetailLabel6)
        let backBtn = makeBackBtn()
        addView.addSubview(backBtn)
        let cancelBtn = makeCancelBtn(searchListView: searchListView)
        addView.addSubview(cancelBtn)
    }
    
    //ーーーーーーーーーーーーーーーお店登録ページーーーーーーーーーーーーー
    @objc func shopRegistrationViewController(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "shopRegistrationSegue", sender: nil)
    }
    //ーーーーーーーーーーーーーーー全リスト一覧ーーーーーーーーーーーーーー
    @IBAction func tappedAllList(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "AllListSegue", sender: nil)
        //allListViewController.allListTableView.reloadData()
    }
    //ーーーーーーーーーーーーー検索ボタンが押された時ーーーーーーーーーーー
    @IBAction func tappedSearch(_ sender: UIButton) {
        //self.shopCollection.fetchShops()
        
        if selectedareas.isEmpty {
            shoplist = self.shopCollection.shops
        }else{
            for selectarea in selectedareas{
                for shoparea in self.shopCollection.shops {
                    if shoparea.area == selectarea {
                        shoplist.append(shoparea)
                    }
                }
            }
        }
        //確認
        for test1 in shoplist{
            print(test1.name)
        }
        print("areaのみで指定した検索結果↑")
        
        if selectedgenres.isEmpty {
            shoplist2 = shoplist
        }else{
            for selectgenre in selectedgenres{
                for shopgenre in  shoplist {
                    if shopgenre.genre == selectgenre {
                        shoplist2.append(shopgenre)
                    }
                }
            }
        }
        //確認
        for name in shoplist2{
            print(name.name)
        }
        print("areaとgenreで指定した検索結果↑")
        
        performSegue(withIdentifier: "toSearchResultSegue", sender: IndexPath.self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSearchResultSegue" {
            let searchResultViewController = segue.destination as!SearchResultViewController
            searchResultViewController.searchShops = shoplist2
            searchResultViewController.selectareas = selectedareas
            searchResultViewController.selectgenres = selectedgenres
            //secondViewController.myText = sender as! String
        }
        
    }
}
