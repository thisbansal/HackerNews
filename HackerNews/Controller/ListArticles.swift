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
    
    let activityIndicator = UIActivityIndicatorView()
    
    let backgroundViewForLabel: UIView = {
        let view                 =  UIView()
        view.backgroundColor     = .black
        view.layer.cornerRadius  = 5
        view.layer.masksToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelForArticleTitle   : UILabel = {
        let label              = UILabel()
        label.numberOfLines    = 0
        label.lineBreakMode    = .byClipping
        label.textColor        = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelForUrlLink        : UILabel = {
        let label              = UILabel()
        label.numberOfLines    = 0
        label.font             = label.font.withSize(11)
        label.lineBreakMode    = .byClipping
        label.textColor        = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: - Methods
    override func prepareForReuse() {
        article                   = nil
        labelForUrlLink.text      = nil
        labelForArticleTitle.text = nil
        self.activityIndicator.removeFromSuperview()
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
        self.activityIndicator.removeFromSuperview()
    }
    
    func configure(_ articleRecieved: Article, index: Int) {
        self.article        = articleRecieved
        if self.article?.url == nil {
            if let id = self.article?.id {
                self.article?.url = URL(string: self.hKAskUrl+"\(id)")
                print ("\(index). \(String(describing: self.article))")
            }
        }
        guard let title     = self.article?.title, let url = self.article?.url else { return }
        self.labelForArticleTitle.text     = "\(index). \(title)"
        self.labelForUrlLink.text          = url.absoluteString
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
