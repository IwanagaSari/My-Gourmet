//
//  AddGenreViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/11/06.
//  Copyright © 2018 iwanaga sari. All rights reserved.
//

import UIKit

class AddGenreViewController: UIViewController, UITextFieldDelegate {
    
    var addGenreView:UIView!
    var backView :UIView!
    var searchListView :UIView!
    var addAreaOrGerne :UITextField!
    
    let genreCollection = GenreCollection()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showCreateGenreView() -> UIView {
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
    
    return searchListView
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
    func makeLabel(text: String, x: CGFloat, y: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: x, y: y, width:280, height:40))
        label.text = text
        label.font = UIFont(name: "HiraKakuProN-W6", size: 25)
        return label
    }
    func makeAddAreaOrGnere() -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x:10, y:70, width:280, height:60)
        textField.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.placeholder = "エリア、シーン、etc..."
        return textField
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
    //キャンセルボタンの実装
    @objc func tappedCancelBtn(_ seder: AnyObject){
        backView.removeFromSuperview()
    }
    //ジャンル追加ボタンの実装
    @objc func tappedGenreSubmitBtn(_ sender: AnyObject){
        
        if  addAreaOrGerne.text != nil {
            self.genreCollection.addGenreCollection(genre: addAreaOrGerne.text!)
            print("ジャンル：\(addAreaOrGerne.text!)")
        }
        //self.searchWayTableView.reloadData()
        backView.removeFromSuperview()
    }

}
