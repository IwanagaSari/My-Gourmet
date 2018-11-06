//
//  ShopRegistrationViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/07/12.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

class ShopRegistrationViewController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var shopNameText: UITextField!
    @IBOutlet weak var shopCommentText: UITextView!
    @IBOutlet weak var shopRateText: UITextField!
    @IBOutlet weak var shopHasGone: UISegmentedControl!
    @IBOutlet weak var shopAreaPicker: UIPickerView!
    @IBOutlet weak var shopGenrePicker: UIPickerView!
    
    let shopCollection = ShopCollection()
    let allListViewController = AllListViewController()
    let shop = Shop()
    let areaCollection = AreaCollection()
    let genreCollection =  GenreCollection()
    
    var shopname: String?
    var shoparea: String?
    var shopgenre: String?
    var shopcomment: String?
    var shoprate: String?
    var shophasgone: ShopHasGone?
    var indexPath: Int?
    
    var areanum: Int?
    var genrenum: Int?
    
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
        shopAreaPicker.delegate = self
        shopAreaPicker.dataSource = self
        shopGenrePicker.delegate = self
        shopGenrePicker.dataSource = self
        
        shopCommentText.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        shopCommentText.layer.borderWidth = 1
        shopCommentText.layer.cornerRadius = 5
        
        //ShopPage2から「編集に戻る」を押した時は、内容を反映させておく
        shopNameText.text = shopname
        shopCommentText.text = shopcomment
        shopRateText.text = shoprate
        //2つのpickerに初期値を設定。
        //1.エリア
        self.areaCollection.fetchAreas()
        if areaCollection.areas == []  {
            print("エリアを入力")
        }else{
            shoparea = areaCollection.areas[0]  //基本的には、1番目のエリアを
        }
        
        if let areaNum = areanum{
            shopAreaPicker.selectRow(areaNum, inComponent: 0, animated: true)
            shoparea = areaCollection.areas[areaNum]
        }
        //2.ジャンル
        self.genreCollection.fetchAreas()
        if genreCollection.genres == []  {
            print("ジャンルを入力")
        }else{
            shopgenre = genreCollection.genres[0]
        }
                
        if let genreNum = genrenum{
            shopGenrePicker.selectRow(genreNum, inComponent: 0, animated: true)
            shopgenre = genreCollection.genres[genreNum]
        }
    
        switch shophasgone {
        case .hasgone? :
            shopHasGone.selectedSegmentIndex = 0
        case .hasnotgone? :
            shopHasGone.selectedSegmentIndex = 1
        default: break
        }
        
        
       
        
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
    //ーーーーーーーーーーpickerviewを実装ーーーーーーーーーーーーーーーーーーーーーーーーーーー
    //列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == shopAreaPicker {
            
            return areaCollection.areas.count
        }else  {
            return genreCollection.genres.count
        }
    }
    //内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //shopAreaPicker.selectRow(areanum!, inComponent: 0, animated: true)
    
        
        if  pickerView == shopAreaPicker {
            return areaCollection.areas[row]
            
        }else {
           return genreCollection.genres[row]
        }
    }
        
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  pickerView == shopAreaPicker {
            shoparea = areaCollection.areas[row]
        } else {
            shopgenre = genreCollection.genres[row]
        }
        
        
    }
    
    @IBAction func registration(_ sender: UIButton) {
        if shopNameText.text!.isEmpty {
            //お店の名前が入力されてなかったらアラートを出す
            let alertView = UIAlertController(title: "エラー", message:"お店の名前を入力して下さい", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        
        }else{
        self.performSegue(withIdentifier: "ShopPageSegue", sender: nil)
        }
        
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        shopNameText.resignFirstResponder()
        shopCommentText.resignFirstResponder()
        shopAreaPicker.resignFirstResponder()
        shopGenrePicker.resignFirstResponder()
        shopRateText.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //実行したい処理
        shopNameText.resignFirstResponder()
        shopCommentText.resignFirstResponder()
        shopRateText.resignFirstResponder()
        shopAreaPicker.resignFirstResponder()
        shopGenrePicker.resignFirstResponder()
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shopPageViewController = segue.destination as!ShopPageViewController
        shopPageViewController.shopname = shopNameText.text
        shopPageViewController.shoparea = shoparea
        shopPageViewController.shopareanum = areanum
        shopPageViewController.shopgenre = shopgenre
        shopPageViewController.shopcomment = shopCommentText.text
        shopPageViewController.shoprate = shopRateText.text
        shopPageViewController.shophasgone =  shopHasGone.selectedSegmentIndex
        shopPageViewController.indexpath = indexPath
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
