//
//  SubRedditViewModel.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import Foundation

/// Delagate protocol for the View Model.
protocol SubRedditViewModelDelegate : AnyObject {
    /// Method signalling we are done loading and parsing data.
    func fetchItemsCompleted()
}

/// View Model holding all the logic for Items.
class SubRedditViewModel {
    
    /// Delegate for item update completed.
    public weak var delegate: SubRedditViewModelDelegate?

    /// A reference to the Networking class - which handles network requests.
    private let networking = Networking()
    
    // Original list of fetched items.
    private var subRedditItems: SubRedditItems? = nil
    
    // Filtered items list.
    private var filteredItems: [SubRedditItem]? = nil
    
    /// A boolean which indicates if the view model should be filtering the fetched results.
    private var filtering = false
    
    /// This func needs to be called to setup this view model.
    /// It runs a network request to Reddit and updates the fetched items list.
    public func setup() {
        networking.getSubReddits(completion: { [weak self] (subRedditItems) in
            // Assign the recieved collection.
            self?.subRedditItems = subRedditItems
            // Dispatch main thread to do the UI updates in the view controller.
            DispatchQueue.main.async {
                // Call delegate method to inform we are done fetching data.
                self?.delegate?.fetchItemsCompleted()
            }
        })
    }
    
    /// This function filters the list of fetched reddit items,
    /// and calls the deligate method.
    ///
    /// - Parameter filterString: string for filtering the results.
    public func filter(filterString: String?) {
        guard let string = filterString else { return }
        guard let items = subRedditItems?.items else { return }
        // Turn on filtering mode
        filtering = true

        let filteredItems = items.filter { item in
            guard let itemTitle = item.subreddit else { return false }
            return itemTitle.lowercased().contains(string.lowercased())
        }
        
        self.filteredItems = filteredItems
        self.delegate?.fetchItemsCompleted()
    }
    
    /// Resets the filtered results to the original list.
    public func clearFilter()  {
        // Turn off filtering mode/
        filtering = false
        // Reset the filtered collection to nil
        filteredItems = nil
        // Call delegate to reload.
        self.delegate?.fetchItemsCompleted()
    }
    
    /// Item count for fetched results.
    ///
    /// - Returns: fetch results item count.
    public func itemCount() -> Int {
        return subRedditItems?.items?.count ?? 0
    }
    
    /// Gets the appropriate fetched results item from the collection of fetched items.
    ///
    /// - Parameter indexPath: IndexPath to get the fetched item from collection.
    /// - Returns: Appropriate item for IndexPath or nil
    public func getSubRedditItemForRow(indexPath: IndexPath) -> SubRedditItem? {
        var collection = subRedditItems?.items

        // If are in filtering mode use the filter collection, rather than default collection.
        if filtering == true {
            collection = filteredItems
        }
        
        // Checks to ensure we are not out of collection bounds
        guard let itemsCount = collection?.count else { return nil }
        guard itemsCount > indexPath.row else { return nil }
        // Fetch the item from collection
        guard let item = collection?[indexPath.row] else { return nil }
        return item
    }
}

