//
//  SubRedditViewModel.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation


class SubRedditViewModel {

    private let networking = Networking()

    public func setup() {
        
        networking.getSubReddits(completion: { (subRedditResponseItems) in
            print("results: \(String(describing: subRedditResponseItems))")
            
        })
        
    }
    
}


enum Endpoints: String {
    case subreddit = "https://www.reddit.com/r/fitness/.json"
}
