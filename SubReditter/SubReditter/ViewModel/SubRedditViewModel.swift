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
    
    public var filteredItems: SubRedditItems? = nil
    
    private var filtering = false
    
    public func search(searchString: String?) {
        networking.getSubReddits(searchText: searchString,
                                 completion: { [weak self] (subRedditItems) in
            print("results: \(String(describing: subRedditItems))")
            DispatchQueue.main.async {
                self?.subRedditItems = subRedditItems
                self?.delegate?.fetchItemsCompleted()
            }
        })
    }
    
    public func filter(filterString: String?) {
        guard let string = filterString else { return }
        guard let items = subRedditItems?.items else { return }
        filtering = true
        print("items : \(items.count)")
        let filteredItems = items.filter { item in
            guard let itemTitle = item.title else { return false }
            return itemTitle.contains(string)
        }
        print("fitlered: \(filteredItems.count)")
        self.filteredItems?.items = filteredItems
        self.delegate?.fetchItemsCompleted()
    }
    
    public func clearFilter()  {
        filtering = false
        filteredItems = nil
        self.delegate?.fetchItemsCompleted()
    }
    
    public func itemCount() -> Int {
        if filtering == true {
            return filteredItems?.items?.count ?? 0
        }
        return subRedditItems?.items?.count ?? 0
    }
    
    public func getSubRedditItemForRow(indexPath: IndexPath) -> SubRedditItem? {
        var collection = subRedditItems?.items
        
        if filtering == true {
            collection = filteredItems?.items
        }
        
        guard let itemsCount = collection?.count else { return nil }
        guard itemsCount >= indexPath.row else { return nil }
        guard let item = collection?[indexPath.row] else { return nil }
        return item
    }
}

