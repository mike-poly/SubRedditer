//
//  SubRedditViewModel.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation


public typealias RedditCompletion = (Bool) -> Void

class SubRedditViewModel {
    
    
    
    public func getSubReddits(completion: @escaping RedditCompletion) {
        
        
        guard let requestURL = URL(string: Endpoints.subreddit.rawValue) else { return }
        
        let request = URLRequest(url: requestURL)
    
        let requestTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                print("Error: \(error)")
                completion(false)
            } else {
                
                print(data?.base64EncodedString())
//                let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String!
                completion(true);
            }
        }
        requestTask.resume()
        
    }
    
}


enum Endpoints: String {
    case subreddit = "https://www.reddit.com/r/fitness/.json"
}
