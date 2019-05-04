//
//  ViewArticle.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 30/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class ViewArticle: UICollectionViewController {
    
    private var articleText : UILabel = {
        let uiLabel           = UILabel()
        uiLabel.textColor     = UIColor.rgb(red: 209, green: 209, blue: 209)
        print ("About to change font")
        uiLabel.font          = UIFont(name: "Avenir Next", size: 8.0)
        uiLabel.text          = "Loading"
        return uiLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .gray
        collectionView.addSubview(articleText)
        self.collectionView.reloadData()
    }
    
    func fetchArticleData(url: URL){
        FetchURL.fetchURL.fetchData(with: url, completion: { (stringValue) in
            self.articleText.text = stringValue
        })
        self.collectionView.reloadData()
    }
    
    func setArticleText(articleLink: String) {
        self.articleText.text = articleLink
    }
}
