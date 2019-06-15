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
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.tintColor = Color.darkBackground.value
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
        label.font             = UIFont(name: "Avenir-Medium", size: 20.0)
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
        self.addSubview(activityIndicator)
        addConstraintWithFormat(format: "H:|[v0]|", view: activityIndicator)
        addConstraintWithFormat(format: "V:|[v0]|", view: activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityView() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func configure(articleRecieved: Article, titleText: String, supportingLabelText: String) {
        self.article        = articleRecieved
        self.labelForArticleTitle.text     = titleText
        self.labelForUrlLink.text          = supportingLabelText
    }
    
    override func setupViews() {
        super.setupViews()
        
        //adding background View for the labels
        addSubview(backgroundViewForLabel)
        addConstraintWithFormat(format: "H:|[v0]|", view: backgroundViewForLabel)
        addConstraintWithFormat(format: "V:|[v0]|", view: backgroundViewForLabel)
        
        //adding labels to the background View
        backgroundViewForLabel.addSubview(labelForArticleTitle)
        addConstraintWithFormat(format: "H:|-[v0]-|", view: labelForArticleTitle)
        addConstraintWithFormat(format: "V:|-16-[v0]", view: labelForArticleTitle)
        
        backgroundViewForLabel.addSubview(labelForUrlLink)
        addConstraintWithFormat(format: "H:|-[v0]|", view: labelForUrlLink)
        addConstraintWithFormat(format: "V:[v0]-8-|", view: labelForUrlLink)
    }
    
}
