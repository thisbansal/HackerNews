//
//  Model.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

//Object model for the article received from Hackernews
public struct Article: Decodable{
    
    var id              : Int?
    var time            : Int?
    
    var url             : URL?
    
    var user            : String?
    var title           : String?
    var type            : String?
    var time_ago        : String?
    var comments_coutn  : String?
    var domain          : String?
    
}
