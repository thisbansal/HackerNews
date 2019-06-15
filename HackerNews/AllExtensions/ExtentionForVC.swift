//
//  ExtentionForViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 9/6/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func getArticle(at index: Int) -> Article? {
        return self.topArticles.indices.contains(index) ? self.topArticles[index] : nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = self.topArticles.count + 1
        if (self.currentBatchForVC == 10) {
            count = self.topArticles.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - 8, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListArticles
        
        guard let article = getArticle(at: indexPath.row) else {
            cell.showActivityView()
            self.batchFetch()
            return cell
        }
        
        guard let title = article.title else {return cell}
        guard let domain = article.domain else {return cell}
        
        cell.configure(articleRecieved: article, titleText: title, supportingLabelText: domain)
        
        return cell
    }
    
    private func batchFetch() {
        self.currentBatchForVC += 1
        if self.currentBatchForVC <= 10 {
            self.fetchArticle { (data) in
                guard var articles = data else {return}
                var indices : [Int] = []
                for (index, article) in articles.enumerated() {
                    if (article.domain == nil) {
                        indices.append(index)
                    }
                }
                articles.remove(at: indices)
                DispatchQueue.main.async {
                    self.topArticles.append(contentsOf: articles)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

