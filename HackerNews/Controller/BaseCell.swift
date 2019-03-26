//
//  BaseCell.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    //MARK: - Random Color
    private let color: [UIColor] = [.blue, .brown]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
//        backgroundColor = color.randomElement()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
