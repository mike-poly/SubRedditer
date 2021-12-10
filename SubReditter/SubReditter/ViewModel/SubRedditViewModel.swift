//
//  SubRedditViewModel.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

protocol SubRedditViewModelDelegate {
    func fetchItemsCompleted()
}

class SubRedditViewModel {
    
    public var delegate: SubRedditViewModelDelegate?

    private let networking = Networking()
    
    public var subRedditItems: SubRedditItems? = nil

    public func setup() {
        networking.getSubReddits(completion: { [weak self] (subRedditItems) in
            print("results: \(String(describing: subRedditItems))")
        
            DispatchQueue.main.async {
                self?.subRedditItems = subRedditItems
                self?.delegate?.fetchItemsCompleted()
            }
        })
    }
    
    public func getSubRedditItemForRow(indexPath: IndexPath) -> SubRedditItem? {
        guard let itemsCount = subRedditItems?.items?.count else { return nil }
        guard itemsCount >= indexPath.row else { return nil }
        guard let item = subRedditItems?.items?[indexPath.row] else { return nil }
        return item
    }
}
