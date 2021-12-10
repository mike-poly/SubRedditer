//
//  SubRedditItem.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

public class SubRedditItems: Codable {
    var items:[SubRedditItem]?
    
    private enum CodingKeys: String, CodingKey {
        case items = "children"
    }
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    init(items: [SubRedditItem]?) {
        self.items = items
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RootCodingKeys.self)
        let nestedValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        items = try nestedValues.decode([SubRedditItem].self, forKey: .items)
    }

}


public class SubRedditItem: Codable {
    var subreddit: String?
    var title: String?
    var url: URL?
    
    private enum CodingKeys: String, CodingKey {
        case subreddit
        case title
        case url
    }
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    init(subreddit: String?, title: String?,  url: URL?) {
        self.subreddit = subreddit
        self.title = title
        self.url = url
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RootCodingKeys.self)
        let nestedValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.subreddit = try nestedValues.decode(String.self, forKey: .subreddit)
        self.title = try nestedValues.decode(String.self, forKey: .title)
        self.url = try nestedValues.decode(URL.self, forKey: .url)
    }
}
