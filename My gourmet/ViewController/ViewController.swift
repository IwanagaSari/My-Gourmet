//
//  ViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/07/11.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
  
    @IBOutlet weak var searchWayTableView: UITableView!
    
    //let shopCollection = ShopCollection()
    //let searchCollection = SearchCollection()
    var backView :UIView!
    var searchListView :UIView!
    var searchWay :UITextField!
    var searchWayDetail1 :UITextField!
    var searchWayDetail2 :UITextField!
    var searchWayDetail3 :UITextField!
    var addView :UIView!
    var addDetail :UITextField!
    
    let allListViewController = AllListViewController()
    let sectionTitle = ["ジャンル", "エリア", "行った・行ってない"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchWayTableView.delegate = self
        searchWayTableView.dataSource  = self
        //searchWay.delegate = self
        //searchWayDetail1.delegate = self
        //searchWayDetail2.delegate = self
        //searchWayDetail3.delegate = self
        //addDetail.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "お店登録", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.shopRegistrationViewController(sender:)))
         self.navigationController!.navigationBar.tintColor = UIColor.white
         //allListViewController.allListTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //ーーーーーーーーーーーーーーーセルの設定ーーーーーーーーーーーーーーーーー
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.searchCollection.lists.count
        return 10
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(20)
    }
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //let search = self.searchCollection.lists[indexPath.row]
        //cell.textLabel?.text = search.title
        //cell.textLabel?.font = UIFont(name: "HirakakuProN-W6", size: 15)
        return cell
    }
    //ーーーーーーーーーーーーーセクションーーーーーーーーーーーーーーー
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return self.searchCollection.lists.count
        return 3
    }
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return reseachMethod[section]
        //return "ジャンル"
        return sectionTitle[section]
    }
    //セクションのタイトルの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    //--------------------キーボードを閉じる実装--------------------------------
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        searchWay.resignFirstResponder()
        searchWayDetail1.resignFirstResponder()
        searchWayDetail2.resignFirstResponder()
        searchWayDetail3.resignFirstResponder()
        //addDetail.resignFirstResponder()
    }
    //-------------------returnを押したらキーボード閉じる------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchWay.resignFirstResponder()
        //searchWayDetail1.resignFirstResponder()
        //searchWayDetail2.resignFirstResponder()
        //searchWayDetail3.resignFirstResponder()
        //addDetail.resignFirstResponder()
        return true
    }
    //ーーーーーーーーートップ画面の検索条件追加ボタンを押した時ーーーーーーーーーーーーーーーー
    @IBAction func addSearchList(_ sender: UIButton) {
        
        //投稿画面後ろの黒い画面を作成
        let backView = makeBackView()
        self.view.addSubview(backView)
        
        searchListView = makeSearchListView()
        backView.addSubview(searchListView)
        
        searchWay = makeSearchWay()
        searchListView.addSubview(searchWay)
        
        searchWayDetail1 = makeSearchWayDetail(placeholder:"魚系、焼肉、etc..",x:90, y: 100)
        searchListView.addSubview(searchWayDetail1)
        searchWayDetail2 = makeSearchWayDetail(placeholder:"",x:90, y:140)
        searchListView.addSubview(searchWayDetail2)
        searchWayDetail3 = makeSearchWayDetail(placeholder:"",x:90, y:180)
        searchListView.addSubview(searchWayDetail3)
        
        
        let searchWayLabel = makeLabel(text: "検索条件", x:10, y: 5)
        searchListView.addSubview(searchWayLabel)
        
        let searchWayDetailLabel1 = makeLabel(text: "条件詳細1",x:10, y: 100)
        searchListView.addSubview(searchWayDetailLabel1)
        let searchWayDetailLabel2 = makeLabel(text: "条件詳細2",x:10, y: 140)
        searchListView.addSubview(searchWayDetailLabel2)
        let searchWayDetailLabel3 = makeLabel(text: "条件詳細3",x:10, y: 180)
        searchListView.addSubview(searchWayDetailLabel3)
        
        let addsearchWayDetail = makeAddSearchWayDetailBtn(searchListView: searchListView)
        searchListView.addSubview(addsearchWayDetail)
        let addsearchWayDetailLabel = makeLabel(text: "詳細追加",x:125, y: 225)
        searchListView.addSubview(addsearchWayDetailLabel)
        //作成！ボタン
        let createBtn = makeCreateBtn(x:100, y:430)
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
        searchListView.frame.size = CGSize(width: 300, height: 500)
        searchListView.center.x = self.view.center.x
        searchListView.center.y = 350
        searchListView.backgroundColor = UIColor.white
        searchListView.layer.shadowOpacity = 0.3
        searchListView.layer.cornerRadius = 3
        return searchListView
    }
    
    func makeSearchWay() -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x:10, y:40, width:280, height:40)
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
        label.font = UIFont(name: "HiraKakuProN-W6", size: 15)
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
    func makeCreateBtn(x: CGFloat, y: CGFloat) -> UIButton {
        let createBtn = UIButton()
        createBtn.frame = CGRect(x:x, y:y, width:100,height:50)
        createBtn.setTitle("作成！", for: .normal)
        createBtn.titleLabel?.font = UIFont(name: "HiraginoMaruGothicProN-W4", size: 15)
        createBtn.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        createBtn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        createBtn.layer.cornerRadius = 7
        createBtn.addTarget(self, action: #selector(self.tappedSubmitBtn(_:)), for:.touchUpInside)
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
    //作成！ボタンの実装
    @objc func tappedSubmitBtn(_ sender :AnyObject){
        let way = searchWay.text!
        let detail1 = searchWayDetail1.text!
        let detail2 = searchWayDetail2.text!
        let detail3 = searchWayDetail3.text!
        print("検索方法:\(way)、条件詳細1:\(detail1)、条件詳細2:\(detail2)、条件詳細3:\(detail3)")
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
        let createBtn = makeCreateBtn(x:100, y:430)
        addView.addSubview(createBtn)
        let detail = addDetail.text!
        print("条件詳細:\(detail)")
    }
    
    //ーーーーーーーーーーーーーーーお店登録ページーーーーーーーーーーー
    @objc func shopRegistrationViewController(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "shopRegistrationSegue", sender: nil)
    }
    
    @IBAction func tappedAllList(_ sender: UIButton) {
        self.performSegue(withIdentifier: "AllListSegue", sender: nil)
        //allListViewController.allListTableView.reloadData()
    }
    @IBAction func tappedSearch(_ sender: UIButton) {
    }
    
}

