//
//  ExtentionForAskVC.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 9/6/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

extension AskViewController: UICollectionViewDelegateFlowLayout {
    
    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func getArticle(at index: Int) -> Article? {
        return self.askArticle.indices.contains(index) ? self.askArticle[index] : nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = self.askArticle.count + 1
        if (self.currentBatch == 2) {
            count = self.askArticle.count
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
        guard let user = article.user else {return cell}
        
        cell.configure(articleRecieved: article, titleText: title, supportingLabelText: user)
        return cell
        
    }
    
    private func batchFetch() {
        self.currentBatch += 1
        if self.currentBatch <= 2 {
            self.fetchArticle { (data) in
                guard let articles = data else {return}
                DispatchQueue.main.async {
                    self.askArticle.append(contentsOf: articles)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}
