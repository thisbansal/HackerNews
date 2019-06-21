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
    
    private func getEstimatedHeightAndWidthOfCell(fontSize: CGFloat, nameOfFont: String, labelString: String) -> CGSize {
        let width = view.frame.width - 12
        let size  = CGSize(width: width, height: 80)
        let attributes = [NSAttributedString.Key.font: UIFont(name: nameOfFont, size: fontSize)]
        
        let estimatedFrame = NSString(string: labelString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return (CGSize(width: view.frame.width, height: estimatedFrame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let title = getArticle(at: indexPath.row)?.title, let bodyLabel = getArticle(at: indexPath.row)?.user {
            let titleLabelSize =  getEstimatedHeightAndWidthOfCell(fontSize: 16.0, nameOfFont: "Avenir-Medium", labelString: title)
            let bodyLabelSize  = getEstimatedHeightAndWidthOfCell(fontSize: 11.0, nameOfFont: "Menlo-Italic", labelString: bodyLabel)
            return CGSize(width: view.frame.width, height: bodyLabelSize.height + titleLabelSize.height + 30)
        }
        
        return CGSize.init(width: collectionView.frame.width - 8, height: 40)
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
