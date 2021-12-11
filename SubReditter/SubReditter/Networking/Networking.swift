//
//  Networking.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

/// Completion block for item fetch completed.
public typealias RedditCompletion = (SubRedditItems?) -> ()

/// Lists all the endpoints we will use for networking.
///
/// - subreddit: the only endpoint we are using - for now.
private enum Endpoints: String {
    case subreddit = "https://www.reddit.com/.json"
}

/// Class handling the networking requests and item parsing.
class Networking {
    
    /// This function fethched the subreddits from the endpoint
    /// and calls the completion block with all the available items.
    ///
    /// - Parameter completion: completion block with the optinal fetched items.
    public func getSubReddits(completion: @escaping RedditCompletion) {
        // Build network request and completion
        guard let requestURL = URL(string: Endpoints.subreddit.rawValue) else { return }
        let request = URLRequest(url: requestURL)
        let requestTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                // Log the error of we have one.
                print("Error: \(String(describing: error?.localizedDescription))")
                // No results in this case.
                completion(nil)
            } else {
                // Fire completion block with decoded results.
                completion(self.decodeData(data: data));
            }
        }
        // Fire network request
        requestTask.resume()
    }
    
    /// Decodes the recived JSON into Model classes.
    ///
    /// - Parameter data: JSON data to decode
    /// - Returns: optional decoded items or nil
    private func decodeData(data: Data?) -> SubRedditItems? {
        guard let jsonData = data else { return nil }
        let decoder = JSONDecoder()
        let subRedditResponseItems = try? decoder.decode(SubRedditItems.self, from: jsonData)
        return subRedditResponseItems
    }
    
}
