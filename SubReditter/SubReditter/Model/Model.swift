//
//  SubRedditItem.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

public struct RedditResponse: Codable {
    var data: SubRedditResponseItems
}

public struct SubRedditResponseItems: Codable {
    var children:[SubRedditItem]
}

public struct SubRedditItem: Codable {
    var data: SubRedditItemData?
}

struct SubRedditItemData: Codable {
    var subreddit: String?
    var title: String?
    var url: String?
}
