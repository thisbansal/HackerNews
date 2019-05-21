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
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            self.fetchArticle(index: indexPath.row) { (data) in
                guard let article = data else {return}
                print ("\(indexPath.row).  \(article)")
                self.topArticles[indexPath.row] = article
            }
        }
    }
    
    
    
    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func getArticle(at index: Int) -> Article? {
        return self.topArticles.indices.contains(index) ? self.topArticles[index] : nil
    }
    
    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func getArticleId(at index: Int) -> Int? {
        return self.articleIDs.indices.contains(index) ? self.articleIDs[index] : nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.topArticles.count == 0) {
            self.topArticles = [Article?](repeating: nil, count: self.articleIDs.count)
        }
        return self.articleIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - 8, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListArticles
        
//        if indexPath.row == self.topArticles.count {
//            cell.showActivityView()
//            self.batchFetch(index: indexPath)
//            return cell
//        }
//        print ("About to configure cell with the follwing Article: \(self.topArticles[indexPath.row])")
        guard let article = getArticle(at: indexPath.row) else {
            cell.showActivityView()
            self.batchFetch(index: indexPath)
            return cell
        }
        cell.configure(article, index: indexPath.row)
        return cell
        
    }
    
    private func batchFetch(index indexPath: IndexPath) {
        self.fetchArticle(index: indexPath.row) { (data) in
            guard let article = data else {return}
            DispatchQueue.main.async {
                self.topArticles[indexPath.row] = article
                self.collectionView.reloadData()
            }
        }
    }
    
}

