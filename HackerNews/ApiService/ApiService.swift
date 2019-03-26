//
//  ApiService.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 23/3/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

//MARK: - Enum
enum ExtendBaseURL : String {
    case topStories = "topstories.json"
    case newStories = "newstories.json"
    case item       = "item"
}

class ApiService: NSObject {
    
    private let baseURL = "https://hacker-news.firebaseio.com/v0"
    static let shared = ApiService()
    
    //MARK: - Properties to fetch
    func fetchTopArticlesIds(completion: @escaping ([Int]?) -> ()) {
        fetchArticleIds(urlString: "\(baseURL)/\(ExtendBaseURL.topStories.rawValue)", completion: completion)
    }
    
    func fetchTopArticlesWithIds(articleId: Int,completion: @escaping (Article?) -> ()) {
        fetchArticleWith(urlString: "\(baseURL)/\(ExtendBaseURL.item.rawValue)/\(articleId).json", completion: completion)
    }
    
    private func fetchArticleWith(urlString: String, completion: @escaping ( Article? ) -> () ) {
        let urlValue = URL(string: urlString)
        if let url = urlValue {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {completion(nil); return}
                do {
                    let article = try JSONDecoder().decode(Article.self, from: data)
                    completion(article)
                }
                catch {
                    completion(nil)
                }
            }
            task.resume()
        }
        else {
            completion (nil)
        }
    }
    
    private func fetchArticleIds(urlString: String, completion: @escaping ( [Int]? ) -> () ) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {completion(nil); return}
                do {
                    let idArray = try JSONDecoder().decode([Int].self, from: data)
                    DispatchQueue.main.async {
                        completion(idArray)
                    }
                }
                catch {
                    completion(nil)
                }
            }
            task.resume()
        }
        else {
            completion (nil)
        }
    }
}
