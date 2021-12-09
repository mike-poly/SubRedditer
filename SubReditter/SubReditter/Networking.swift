//
//  Networking.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

public typealias RedditCompletion = (RedditResponse?) -> ()

class Networking {
    
    public func getSubReddits(completion: @escaping RedditCompletion) {
        
        
        guard let requestURL = URL(string: Endpoints.subreddit.rawValue) else { return }
        
        let request = URLRequest(url: requestURL)
        
        let requestTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                print("Error: \(error)")
                completion(nil)
            } else {
                completion(self.decodeData(data: data));
            }
        }
        requestTask.resume()
        
    }
    
    private func decodeData(data: Data?) -> RedditResponse? {
        guard let jsonData = data else { return nil }
        
         print("data: \(jsonData)")
        
        let decoder = JSONDecoder()
        let subRedditResponseItems = try? decoder.decode(RedditResponse.self, from: jsonData)
        
        return subRedditResponseItems
    }
    
}
