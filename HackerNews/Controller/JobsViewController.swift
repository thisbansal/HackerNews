//
//  JobsViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 9/6/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class JobsViewController: UICollectionViewController {
    
    // MARK: - Properties
    let cellId                                  = "cellId"
    let viewTitle                               = "Jobs"
    public let itemURL                          = "https://news.ycombinator.com/"
    
    public var askArticle  : [Article?]        = []
    public var urlRequests  : [ApiService]      = []
    public var currentBatch : Int               = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard let url      = cell?.article?.url else { return }
        let webView        = WebViewController()
        webView.loadURLForWebView(url)
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    //MARK: - Get the Articles
    public func fetchArticle(completion: @escaping ([Article]?) -> ()) {
        let apiService        = ApiService()
        self.urlRequests.append(apiService)
        apiService.fetchArticlesForBatch(batchNumber: self.currentBatch, baseRequest: .jobs) { (data) in
            guard let data = data else {completion(nil); return}
            completion(data)
        }
    }
    
}
