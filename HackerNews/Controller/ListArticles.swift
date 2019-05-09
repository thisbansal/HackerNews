//
//  ListArticles.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class ListArticles: BaseCell {
    
    //MARK: - Properties
    var article: Article?
    {
        didSet {
            if let title = article?.title {
                label.text = "\(title)"
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
    
    var backgroundViewForLabel: UIView = {
        let view                 =  UIView()
        view.backgroundColor     = .black
        view.layer.cornerRadius  = 5
        view.layer.masksToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var label : UILabel = {
        let label              = UILabel()
        label.numberOfLines    = 0
        label.lineBreakMode    = .byClipping
        label.textColor        = .white
        label.sizeToFit()
        label.text             = "Loading"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: - Methods
    override func prepareForReuse() {
        article    = nil
        label.text = "Loading"
    }
    
    func configure(_ articleRecieved: Article) {
        article = articleRecieved
        label.text = article?.title
    }
    
    override func setupViews() {
        super.setupViews()
        
        //adding background View for the labels
        addSubview(backgroundViewForLabel)
        addConstraintWithFormat(format: "H:|[v0]|", view: backgroundViewForLabel)
        addConstraintWithFormat(format: "V:|[v0]|", view: backgroundViewForLabel)
        
        //adding labels to the background View
        backgroundViewForLabel.addSubview(label)
        addConstraintWithFormat(format: "H:|-[v0]-|", view: label)
        addConstraintWithFormat(format: "V:|-[v0]-|", view: label)
    }
    
}
