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
    public var articleIDs                       : [Int]?
    public var topArticles  : [Article]         = []
    public var apiServices  : [Int:ApiService]  = [:]
    
    var nextIndexForBatchUpdate  : Int               = 0
    let batchToPreload      : Int               = 14
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch the top articles from the HackerNews
        fetchTopArticlesIds()
        
        self.navigationController?.navigationBar.barTintColor        = UIColor.rgb(red: 28, green: 28, blue: 28)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        self.navigationItem.title                                    = viewTitle
        
        collectionView.dataSource                                    = self
        collectionView.delegate                                      = self
        
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
    public func fetchArticles(from indexOrigin: Int, completion: @escaping ([Article]?) -> ()) {
        var emptyArrayList : [Article]  = [Article](repeating: Article(), count: 14)
        for index in 0..<14 {
            guard let iD = self.articleIDs?[indexOrigin + index] else {return}
            let apiService   = ApiService()
            apiService.fetchTopArticlesWithIds(articleId: iD, completion: { (optionalArticle) in
                guard let article = optionalArticle else {completion(nil); return}
                emptyArrayList[index] = article
                print (article)
            })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if emptyArrayList.count == 14 {
                completion(emptyArrayList)
                return
            }
        }
    }
}

