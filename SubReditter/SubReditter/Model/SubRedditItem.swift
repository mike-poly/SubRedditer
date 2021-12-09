//
//  SubRedditItem.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

struct SubRedditResponseItems: Codable {
    var children:[SubRedditItem]
}

struct SubRedditItem: Codable {
    var subreddit: String?
    var title: String?
    var urlString: String?
    
    enum CodingKeys: String, CodingKey {
        case urlString = "url"
    }
}
