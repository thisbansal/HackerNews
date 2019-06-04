//
//  Extentions.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 17/4/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

extension Array {
    mutating func remove(at indexes: [Int]) {
        for index in indexes.sorted(by: >) {
            remove(at: index)
        }
    }
}

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
        if (self.currentBatch == 10) {
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
        
        cell.configure(article, indexPath.row)
        return cell
        
    }
    
    private func batchFetch() {
        self.currentBatch += 1
        if self.currentBatch <= 10 {
            self.fetchArticle { (data) in
                guard let articles = data else {return}
                DispatchQueue.main.async {
                    self.topArticles.append(contentsOf: articles)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

