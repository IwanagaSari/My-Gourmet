//
//  SafariViewController.swift
//  My gourmet
//
//  Created by 岩永彩里 on 2018/11/05.
//  Copyright © 2018 iwanaga sari. All rights reserved.
//

import UIKit
import WebKit

class OpenSafari: UIViewController {

    @IBOutlet weak var safariView: WKWebView!
    
    var searchName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testurl = "https://www.google.co.jp/search?q=\(searchName)"
        testurl = testurl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = URL(string: testurl)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
