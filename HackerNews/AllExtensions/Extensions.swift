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

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func getArticle(at index: Int) -> Article? {
        return self.topArticles.indices.contains(index) ? self.topArticles[index] : nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let range = self.articleIDs?.count else {
            return 0
        }
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
        
        //check id data is already present locally
        guard let article = getArticle(at: indexPath.row) else {
            //fetch the initial data
            if ((indexPath.row == 0)){
                //if data is not present locally, following block of code
                //fetches it and displays it on uicollectionView
                //Folling piece of code has a bug. If network is slow it might not
                //be able to show the fetched data at all :(
                self.fetchArticles(from: nextIndexForBatchUpdate) { (shouldProceed) in
                    if let articleArray = shouldProceed {
                        DispatchQueue.main.async {
                            self.topArticles.append(contentsOf: articleArray)
                            self.collectionView.indexPathsForVisibleItems.forEach({ (tempIndexPath) in
                                let tempCell = self.collectionView.cellForItem(at: tempIndexPath) as! ListArticles
                                tempCell.configure(self.topArticles[tempIndexPath.row])
                            })
                            self.nextIndexForBatchUpdate += self.batchToPreload
                            print ("nextIndexForBatchUpdate is: \(self.nextIndexForBatchUpdate)")
                        }
                    }
                }
            }
            
            
            return cell
        }
        cell.article = article
        cell.configure(article)
        
        //prefetching
        if (indexPath.row == (self.nextIndexForBatchUpdate - 4)) {
            self.fetchArticles(from: self.nextIndexForBatchUpdate) { (shouldProceed) in
                if let articleArray = shouldProceed {
                    self.topArticles.append(contentsOf: articleArray)
                    self.nextIndexForBatchUpdate += self.batchToPreload
                    print ("nextIndexForBatchUpdate is: \(self.nextIndexForBatchUpdate)")
                    print("\nTopArticles Count: \(self.topArticles.count)")
                }
            }
        }
        return cell
    }
}

