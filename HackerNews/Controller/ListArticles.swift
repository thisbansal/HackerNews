//
//  ListArticles.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit
import SnapKit

class ListArticles: BaseCell {
    
    //MARK: - Properties
    var article: Article? {
        didSet {
            if let article = article?.title {
                label.text = "\(article))"
                label.textColor = .white
            }
        }
    }
    
    var stackView : UIStackView = {
        let stackView             = UIStackView()
        stackView.alignment       = .fill
        stackView.axis            = .vertical
        stackView.distribution    = .fillEqually
        stackView.spacing         = 5
        stackView.backgroundColor = .black
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var label : UILabel = {
        let label              = UILabel()
        label.numberOfLines    = 0
        label.lineBreakMode    = .byClipping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Properties
    func fetchArticleForCell(articleId: Int) {
        ApiService.shared.fetchTopArticlesWithIds(articleId: articleId) { (article) in
            if let article = article {
                DispatchQueue.main.async {
                    self.article = article
                }
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(stackView)
        setupStackView()
        stackView.addSubview(label)
    }
    
    private func setupStackView() {
        stackView.snp.makeConstraints { (make) in
            make.width.height.lessThanOrEqualToSuperview()
        }
    }
}
