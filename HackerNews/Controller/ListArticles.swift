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
    var article  : Article?
    let hKAskUrl : String        = "https://news.ycombinator.com/item?id="
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator   = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = Color.darkBackground.value
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    let backgroundViewForLabel: UIView = {
        let view                 =  UIView()
        view.backgroundColor     = Color.lightBackground.value
        view.layer.cornerRadius  = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelForArticleTitle   : UILabel = {
        let label              = UILabel()
        label.font             = UIFont(name: "Avenir-Medium", size: 16.0)
        label.numberOfLines    = 0
        label.lineBreakMode    = .byClipping
        label.textColor        = Color.darkText.value
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelForUrlLink        : UILabel = {
        let label              = UILabel()
        label.font             = UIFont(name: "Menlo-Italic", size: 11.0)
        label.numberOfLines    = 0
        label.lineBreakMode    = .byClipping
        label.textColor        = Color.darkText.value
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Methods
    override func prepareForReuse() {
        article                   = nil
        labelForUrlLink.text      = nil
        labelForArticleTitle.text = nil
        stopActivityView()
    }
    
    
    //Mark : - Show activity
    func showActivityView() {
        self.labelForArticleTitle.text = nil
        contentView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityView() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func configure(articleRecieved: Article, titleText: String, supportingLabelText: String) {
        self.article                       = articleRecieved
        self.labelForArticleTitle.text     = titleText
        self.labelForUrlLink.text          = supportingLabelText
    }
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(backgroundViewForLabel)
        backgroundViewForLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive           = true
        backgroundViewForLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive   = true
        backgroundViewForLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundViewForLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive     = true
        
        backgroundViewForLabel.addSubview(labelForArticleTitle)
        labelForArticleTitle.topAnchor.constraint(equalTo: backgroundViewForLabel.topAnchor, constant: 8).isActive            = true
        labelForArticleTitle.leadingAnchor.constraint(equalTo: backgroundViewForLabel.leadingAnchor, constant: 8).isActive    = true
        labelForArticleTitle.trailingAnchor.constraint(equalTo: backgroundViewForLabel.trailingAnchor, constant: -8).isActive = true
        
        backgroundViewForLabel.addSubview(labelForUrlLink)
//        labelForUrlLink.topAnchor.constraint(equalTo: labelForArticleTitle.lastBaselineAnchor, constant: 8).isActive           = true
        labelForUrlLink.leadingAnchor.constraint(equalTo: backgroundViewForLabel.leadingAnchor, constant: 8).isActive          = true
        labelForUrlLink.trailingAnchor.constraint(equalTo: backgroundViewForLabel.trailingAnchor, constant: -8).isActive       = true
        labelForUrlLink.lastBaselineAnchor.constraint(equalTo: backgroundViewForLabel.bottomAnchor, constant: -8).isActive     = true
    }
    
}
