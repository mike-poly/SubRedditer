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
    
    public var subReditItems: SubRedditItems? = nil

    public func setup() {
        
        networking.getSubReddits(completion: { (subRedditItems) in
            print("results: \(String(describing: subRedditItems))")
            
        })
        
    }
    
}


enum Endpoints: String {
    case subreddit = "https://www.reddit.com/r/fitness/.json"
}
