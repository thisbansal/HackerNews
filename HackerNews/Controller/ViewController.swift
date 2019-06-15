//
//  ViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UICollectionViewController {
    
    // MARK: - Properties
    let cellId                                  = "cellId"
    let viewTitle                               = "News"
    public var topArticles  : [Article?]        = []
    public var urlRequests  : [ApiService]      = []
    public var currentBatchForVC : Int          = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetches the ids' for the top articles to be loaded from the HackerNews
        
        self.navigationController?.navigationBar.barTintColor        = Color.darkBackground.value
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.lightText.value]
        self.navigationItem.title                                    = viewTitle
        
        collectionView.dataSource                                    = self
        collectionView.delegate                                      = self
        
        collectionView.backgroundColor                               = Color.darkBackground.value
        collectionView.register(ListArticles.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell           =  collectionView.cellForItem(at: indexPath) as? ListArticles
        print(String(describing: self.topArticles.count))
        guard let url      = cell?.article?.url else { return }
        let webView        = WebViewController()
        webView.loadURLForWebView(url)
        self.navigationController?.pushViewController(webView, animated: true)
    }

    //MARK: - Get the Articles
    public func fetchArticle(completion: @escaping ([Article]?) -> ()) {
        let apiService        = ApiService()
        self.urlRequests.append(apiService)
        apiService.fetchArticlesForBatch(batchNumber: self.currentBatchForVC, baseRequest: .news) { (data) in
            guard let data = data else {completion(nil); return}
            completion(data)
        }
    }
    
}

