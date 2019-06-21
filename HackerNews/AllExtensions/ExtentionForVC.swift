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
    
    private func getEstimatedHeightAndWidthOfCell(fontSize: CGFloat, nameOfFont: String, labelString: String) -> CGSize {
        let width = view.frame.width - 12
        let size  = CGSize(width: width, height: 80)
        let attributes = [NSAttributedString.Key.font: UIFont(name: nameOfFont, size: fontSize)]
        
        let estimatedFrame = NSString(string: labelString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return (CGSize(width: view.frame.width, height: estimatedFrame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let title = getArticle(at: indexPath.row)?.title, let bodyLabel = getArticle(at: indexPath.row)?.domain {
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
                    //Removes the ASK HN posts
                    if (article.domain == nil) {
                        indices.append(index)
                    }
                    //Removes the job related posts
                    if let type = article.type {
                        if (type == "job") {
                            indices.append(index)
                        }
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

