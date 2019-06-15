//
//  NavigationBarColorProfile.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 14/6/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

enum Color {
    
    case selectedTabBarColor
    
    case darkBackground
    case lightBackground
    
    case darkText
    case lightText
    case intermidiateText
    
}

extension Color {
    
    var value: UIColor {
        
        var instanceColor = UIColor.clear
        
        switch self {
            case .selectedTabBarColor:  instanceColor = UIColor.cyan
            case .darkBackground:       instanceColor = UIColor.black
            case .lightBackground:      instanceColor = UIColor.lightGray
            case .darkText:             instanceColor = UIColor.black
            case .intermidiateText:     instanceColor = UIColor.lightGray
            case .lightText:            instanceColor = UIColor.white
        }
        
        return instanceColor
    }
}
