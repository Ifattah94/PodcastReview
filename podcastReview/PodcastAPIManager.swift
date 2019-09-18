//
//  PodcastAPIManager.swift
//  podcastReview
//
//  Created by C4Q on 9/18/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation

class PodcastAPIManager {
    private init() {}
    
    static let shared = PodcastAPIManager()
    
    func getPodcasts(searchWord: String, completionHandler: @escaping (Result<[Podcast], AppError>) -> Void) {
        let urlStr = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchWord)"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let podcastInfo = try JSONDecoder().decode(PodcastInfo.self, from: data)
                    completionHandler(.success(podcastInfo.results))
                } catch {
                completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    
    
}
