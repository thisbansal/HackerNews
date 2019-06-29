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
    
    case lightBackgroundLevel2
    
    case darkText
    case lightText
    case intermidiateText
    
    case progressViewTintColor
}

extension Color {
    
    var value: UIColor {
        
        var instanceColor = UIColor.clear
        
        switch self {
            case .progressViewTintColor: instanceColor = UIColor.red
            case .lightBackgroundLevel2: instanceColor = UIColor.rgb(red: 61, green: 61, blue: 61)
            case .selectedTabBarColor:   instanceColor = UIColor.cyan
            case .darkBackground:        instanceColor = UIColor.black
            case .lightBackground:       instanceColor = UIColor.lightGray
            case .darkText:              instanceColor = UIColor.black
            case .intermidiateText:      instanceColor = UIColor.lightGray
            case .lightText:             instanceColor = UIColor.white
        }
        
        return instanceColor
    }
}
