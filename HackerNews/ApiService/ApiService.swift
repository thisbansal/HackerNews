//
//  ApiService.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import Foundation

class ApiService: URLSessionTask {
    
    private let baseURLForHackerNewsPWAS   = "https://api.hnpwa.com/v0/news/"
    
    //MARK: - Properties to fetch
    func fetchArticlesForBatch(batchNumber: Int, completion: @escaping ([Article]?) -> ()) {
        let url  =  URL(string: "\(baseURLForHackerNewsPWAS)\(batchNumber).json")
        guard let fromAddress = url else {completion(nil); return}
        fetchArticles(requestData: fromAddress, completion: completion)
    }
    
    private func fetchArticles(requestData: URL, completion: @escaping ([Article]?) -> ()) {
        print ("request url is: \(String(describing: requestData))")
        let defaultConfiguration = URLSessionConfiguration.default
        let session              = URLSession(configuration: defaultConfiguration)
        let task                 = session.dataTask(with: requestData) { (data, _, _) in
            guard let data    = data else {completion(nil);  return}
            do {
                var articles        = try JSONDecoder().decode([Article].self, from: data)
                var indices : [Int] = []
                for (index, article) in articles.enumerated() {
                    if (article.domain == nil) {
                        print ("About to remove article: \(article)")
                        indices.append(index)
                    }
                }
                articles.remove(at: indices)
                for (index, article) in articles.enumerated() {
                    print ("\(index). \(article) \n")
                }
                completion(articles)
            }
            catch {
                completion (nil)
            }
        }
        task.resume()
    }
}
