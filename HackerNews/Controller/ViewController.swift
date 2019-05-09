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
    let cellId                              = "cellId"
    let viewTitle                           = "Top Articles"
    public var articleIDs                   : [Int]?
    public var topArticles  : [Article?]    = [Article?](repeating: nil, count: 20)
    public var apiServices : [ApiService]   = []
    
    private var operation      : Operation = {
        let operation          = Operation()
        return operation
    }()
    private var operationQueueForArticles : OperationQueue = {
        let operationQueue     = OperationQueue()
        operationQueue.name    = "Download article"
        return operationQueue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch the top articles from the HackerNews
        fetchTopArticlesIds()
        
        self.navigationController?.navigationBar.barTintColor        = UIColor.rgb(red: 28, green: 28, blue: 28)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        self.navigationItem.title                                    = viewTitle
        
        collectionView.dataSource                                    = self
        collectionView.delegate                                      = self
        collectionView.prefetchDataSource                            = self
        
        collectionView.backgroundColor                               = UIColor.rgb(red: 28, green: 28, blue: 28)
        collectionView.register(ListArticles.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath) as? ListArticles
        print (cell?.article ?? "Article is not set")
        guard let url   = cell?.article?.url else { return }
        let webView        = WebViewController()
        webView.loadURLForWebView(url)
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    //MARK: - Get The Ids
    private func fetchTopArticlesIds() {
        let apiService = ApiService()
        apiService.fetchTopArticlesIds(completion: { (receivedArray: [Int]?) in
            if let structData   = receivedArray {
                self.articleIDs = structData
            }
            self.collectionView?.reloadData()
        })
    }

    //MARK: - Get the Articles
    public func fetchArticle(_ index: Int, completion: @escaping (Bool?) -> ()) {
        guard let articleID = self.articleIDs?[index] else {return}
        // if there is already existing data task for the specific news, it means we already loaded it previously / currently loading it
        // stop re-downloading it by returning this function
        if apiServices.firstIndex(where: { task in
            task.getArticleId() == articleID
        }) != nil {
            completion(true)
            return
        }
        
        let apiService = ApiService()
        apiService.fetchTopArticlesWithIds(articleId: articleID) { (article) in
            guard let article = article else {return}
            self.topArticles[index] = article
            completion(true)
        }
        apiServices.append(apiService)
    }
}

