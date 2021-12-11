//
//  SubRedditTableViewController.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import UIKit

/// The Root view controller of the app. Shows a table view of fetched subreddit items.
class SubRedditTableViewController: UITableViewController, SubRedditViewModelDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Instance of view model.
    private let viewModel = SubRedditViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Reddits"
        
        // Set delegates and view model
        searchBar.delegate = self
        viewModel.delegate = self
        viewModel.setup()
    }
    
    // MARK: - SubRedditViewModelDelegate
    
    func fetchItemsCompleted() {
        // Reload items when view model is done updating.
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubRedditTableViewCell.reuseIdentifier, for: indexPath)
        
        // Setup for custom table view cell
        if let subRedditCell = cell as? SubRedditTableViewCell {
            let subRedditItem = viewModel.getSubRedditItemForRow(indexPath: indexPath)
            subRedditCell.titleLabel?.text = subRedditItem?.title
            subRedditCell.subredditLabel?.text = subRedditItem?.subreddit
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Find the appropriate item in the view model for the indexPath and extract the URL.
        let subRedditItem = viewModel.getSubRedditItemForRow(indexPath: indexPath)
        guard let url = subRedditItem?.url else { return }
        
        // Create a web view controller.
        let webViewController = RedditWebViewController()
        // pass the url of out item for it to load.
        webViewController.url = url
        
        // Push web view controller.
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    // MARK: - Search bar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss keyboard
        searchBar.resignFirstResponder()
        sendSearchToViewModel(text: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sendSearchToViewModel(text: searchBar.text)
    }
    
    /// Send the string in the search bar to the view model
    /// to perform a search on the fetched items.
    /// If the string is empty - no search is performed.
    ///
    /// - Parameter text: string to filter the subreddits by.
    private func sendSearchToViewModel(text: String?) {
        if text == "" {
            viewModel.clearFilter()
            return
        }
        // send search string to view model
        viewModel.filter(filterString: text)
    }
}
