//
//  Extentions.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 17/4/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintWithFormat(format: String, view: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in view.enumerated() {
            let key                                        = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key]                           = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let range = self.articleIDs?.count else {
            return 0
        }
        self.topArticles = [Article?](repeating: nil, count: range)
        return range
    }
    /**
    *   fulfilling UICollectionViewDelegateFlowLayout protocol
    */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - 8, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListArticles

        if let availableArticle = self.topArticles[indexPath.row] {
            print ("article found")
            cell.article = availableArticle
            return cell
        }
        
        fetchArticle(indexPath.row) { (isArticleAvailable) in
            guard isArticleAvailable != nil else {return}
            DispatchQueue.main.async {
                if self.collectionView.indexPathsForVisibleItems.contains(indexPath) {
//                    cell.article = self.topArticles[indexPath.row]
                    guard let article = self.topArticles[indexPath.row] else {return}
                    cell.configure(article)
                }
            }
        }
        return cell
    }
    
    
    /**
     *   fulfilling UICollectionViewDataSOurcePrefetching protocol
     */
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let id  = self.articleIDs?[indexPath.row] {
                let apiService = ApiService()
                apiService.fetchTopArticlesWithIds(articleId: id) { (article) in
                    if let article      = article {
                        self.topArticles[indexPath.row] = article
                    }
                }
                apiServices.append(apiService)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            //get the article which is already present in local [topArticle arr]
            guard let article              = self.topArticles[indexPath.row] else {return}

            //gets hold of the apiURLSessionTask from [ApiServices arr] for given articleID
            //articleID is based on indexPaths for cancel Prefetching cells
            //After getting the hold of the apiURLSessionTask, cancels the request immediately
            guard let apiSessionIndex      = apiServices.firstIndex(where: { (apiService) -> Bool in
                apiService.getArticleId() == article.id
            }) else {return}
            print (apiServices[apiSessionIndex].getArticleId() as Any)
            apiServices[apiSessionIndex].cancel()
        }
    }
}

