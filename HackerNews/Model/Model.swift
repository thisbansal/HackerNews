//
//  Model.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import Foundation

public struct Article: Decodable {
    var by: String?
    var id: Int?
    var time: Int?
    var title: String?
    var type: String?
    var url: URL?
    
    init(id: Int) {
        self.id = id
    }
}

