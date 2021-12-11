//
//  Model.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

/// Parent Model class with a collection holding all the fetched items.
public class SubRedditItems: Codable {
    /// A collection of items we recieved from reddit.
    var items:[SubRedditItem]?
    
    // Nested coding keys
    private enum CodingKeys: String, CodingKey {
        case items = "children"
    }
    
    //Root coding keys
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    init(items: [SubRedditItem]?) {
        self.items = items
    }
    
    required public init(from decoder: Decoder) throws {
        // decode the root container.
        let values = try decoder.container(keyedBy: RootCodingKeys.self)
        // decode the nested container.
        let nestedValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        // decode items in the nested container.
        items = try nestedValues.decode([SubRedditItem].self, forKey: .items)
    }

}


/// A Model representing a single instance of a Subreddit.
public class SubRedditItem: Codable {
    /// Subreddit string
    var subreddit: String?
    /// Title string
    var title: String?
    /// URL
    var url: URL?

    // Nested coding keys
    private enum CodingKeys: String, CodingKey {
        case subreddit
        case title
        case url
    }
    
    // Root coding keys
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    init(subreddit: String?, title: String?,  url: URL?) {
        self.subreddit = subreddit
        self.title = title
        self.url = url
    }
    
    required public init(from decoder: Decoder) throws {
        // decode root container
        let values = try decoder.container(keyedBy: RootCodingKeys.self)
        // decode nested container.
        let nestedValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        // decode the property values
        self.subreddit = try nestedValues.decode(String.self, forKey: .subreddit)
        self.title = try nestedValues.decode(String.self, forKey: .title)
        self.url = try nestedValues.decode(URL.self, forKey: .url)
    }
}
