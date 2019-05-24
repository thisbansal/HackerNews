//
//  ViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UICollectionViewController, WKUIDelegate {
    
    // MARK: - Properties
    let cellId                                  = "cellId"
    let viewTitle                               = "Top Articles"
    public var articleIDs   : [Int]             = []
    public var topArticles  : [Article?]        = []

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch the top articles from the HackerNews
        fetchTopArticlesIds()
        
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
    
    //MARK: - Get The Ids
    private func fetchTopArticlesIds() {
        let apiService          = ApiService()
        apiService.fetchTopArticlesIds(completion: { (receivedArray: [Int]?) in
            if let structData   = receivedArray {
                self.articleIDs = structData
            }
            self.collectionView?.reloadData()
        })
    }

    //MARK: - Get the Articles
    public func fetchArticle(index: Int, completion: @escaping (Article?) -> ()) {        
        guard let iD          = getArticleId(at: index) else {completion(nil); return}
        let apiService        = ApiService()
        apiService.fetchTopArticlesWithIds(articleId: iD, completion: { (optionalArticle) in
            guard let article = optionalArticle else {completion(nil);return}
            completion(article)
        })
    }
    
}

