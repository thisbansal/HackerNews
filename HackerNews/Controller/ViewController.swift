//
//  ViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    let cellId = "cellId"
    private var articleIDs  : [Int]?
    
    // MARK: - Methods
    private func fetchTopArticlesIds() {
        ApiService.shared.fetchTopArticlesIds(completion: { (receivedArray: [Int]?) in
            if let structData = receivedArray {
                self.articleIDs = structData
            }
            self.collectionView?.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopArticlesIds()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .gray
        collectionView.performBatchUpdates(nil, completion: nil)
        collectionView.register(ListArticles.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleIDs?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListArticles
        if let articleId = articleIDs {
            cell.fetchArticleForCell(articleId: articleId[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - 8, height: 120)
    }
}
