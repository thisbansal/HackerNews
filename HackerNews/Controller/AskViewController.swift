//
//  AskViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 9/6/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class AskViewController: UICollectionViewController {

    // MARK: - Properties
    let cellId                                  = "cellId"
    let viewTitle                               = "Ask"
    public let itemURL                          = "https://news.ycombinator.com/"
    
    public var askArticle  : [Article?]        = []
    public var urlRequests  : [ApiService]      = []
    public var currentBatch : Int               = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard let askURL   = cell?.article?.url else {return}
        guard let url      = getArticleURL(urlString: askURL.absoluteString) else {return}
        let webView        = WebViewController()
        webView.loadURLForWebView(url)
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    private func getArticleURL(urlString: String) -> URL? {
        return URL(string: "\(self.itemURL)\(urlString)")
    }
    
    //MARK: - Get the Articles
    public func fetchArticle(completion: @escaping ([Article]?) -> ()) {
        let apiService        = ApiService()
        self.urlRequests.append(apiService)
        apiService.fetchArticlesForBatch(batchNumber: self.currentBatch, baseRequest: .ask) { (data) in
            guard let data = data else {completion(nil); return}
            completion(data)
        }
    }

}
