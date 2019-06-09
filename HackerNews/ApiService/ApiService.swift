//
//  ApiService.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import Foundation

enum ItemFeeds : String {
    
    case news = "https://api.hnpwa.com/v0/news/"
    case ask    = "https://api.hnpwa.com/v0/ask/"
    case show    = "https://api.hnpwa.com/v0/show/"
    case jobs    = "https://api.hnpwa.com/v0/jobs/"
    
}

class ApiService: URLSessionTask {
    
    //MARK: - Properties to fetch
    func fetchArticlesForBatch(batchNumber: Int, baseRequest: ItemFeeds, completion: @escaping ([Article]?) -> ()) {
        print("\(baseRequest.rawValue)\(batchNumber).json")
        let url  =  URL(string: "\(baseRequest.rawValue)\(batchNumber).json")
        guard let fromAddress = url else {completion(nil); return}
        fetchArticles(requestData: fromAddress, completion: completion)
    }
    
    private func fetchArticles(requestData: URL, completion: @escaping ([Article]?) -> ()) {
        let defaultConfiguration = URLSessionConfiguration.default
        let session              = URLSession(configuration: defaultConfiguration)
        let task                 = session.dataTask(with: requestData) { (data, _, _) in
            guard let data    = data else {completion(nil);  return}
            do {
                let articles        = try JSONDecoder().decode([Article].self, from: data)
                completion(articles)
            }
            catch {
                completion (nil)
            }
        }
        task.resume()
    }
}
