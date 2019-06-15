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
    /// Takes the input paramenters required to be fetched later. This method is just
    /// an intermediate place where the base URL is formed based on the input
    /// paramenters it takes. Later base URL is combined with batchNumber to form an
    /// absolute URL and sent to the function to download the data.
    ///
    /// - Parameters:
    ///   - batchNumber: holds the track of current batch number
    ///   - baseRequest: determines what address to call to in order to receive data
    ///   - completion: returns the fetched data
    func fetchArticlesForBatch(batchNumber: Int, baseRequest: ItemFeeds, completion: @escaping ([Article]?) -> ()) {
        let url  =  URL(string: "\(baseRequest.rawValue)\(batchNumber).json")
        print("About to fetch: \(String(describing: url))")
        guard let fromAddress = url else {completion(nil); return}
        fetchArticles(requestData: fromAddress, completion: completion)
    }
    
    /// Fetches the data from the given article. It returns either nil, if data is not available
    /// Or returns an array of actual "Article".
    ///
    /// - Parameters:
    ///   - requestData: URL to fetch the data from
    ///   - completion: closure, either returns nil or array of Article
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
