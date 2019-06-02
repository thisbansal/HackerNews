//
//  WebViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 5/5/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var urlToLoad : URLRequest?
    
    var webView: WKWebView! = {
        let webview = WKWebView()
        return webview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor  = UIColor.white
        
        self.view.addSubview(webView)
        self.view = webView
    }
    
    func loadURLForWebView(_ urlString: URL) {
        let myRequest = URLRequest(url: urlString)
        webView.load(myRequest)
    }
    
}
