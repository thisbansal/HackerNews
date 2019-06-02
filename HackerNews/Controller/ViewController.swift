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
    let viewTitle                               = "Top Articles"
//    public var articleIDs   : [Int]             = []
    public var topArticles  : [Article?]        = []
    public var urlRequests  : [ApiService]      = []
    public var currentBatch : Int               = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetches the ids' for the top articles to be loaded from the HackerNews
//        fetchTopArticlesIds()
        
        self.navigationController?.navigationBar.barTintColor        = UIColor.orange
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationItem.title                                    = viewTitle
        
        collectionView.dataSource                                    = self
        collectionView.delegate                                      = self
        
        collectionView.backgroundColor                               = UIColor.rgb(red: 28, green: 28, blue: 28)
        collectionView.register(ListArticles.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell           =  collectionView.cellForItem(at: indexPath) as? ListArticles
        guard let url      = cell?.article?.url else { return }
        let webView        = WebViewController()
        webView.loadURLForWebView(url)
        self.navigationController?.pushViewController(webView, animated: true)
    }

    //MARK: - Get the Articles
    public func fetchArticle(completion: @escaping ([Article]?) -> ()) {
        let apiService        = ApiService()
        self.urlRequests.append(apiService)
        apiService.fetchArticlesForBatch(batchNumber: self.currentBatch) { (data) in
            guard let data = data else {completion(nil); return}
            completion(data)
        }
    }
    
}

