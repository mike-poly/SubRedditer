//
//  SubRedditTableViewController.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-09.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import UIKit

class SubRedditTableViewController: UITableViewController, SubRedditViewModelDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = SubRedditViewModel()
    
    var searchString: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavItems()
        
        searchBar.delegate = self
        viewModel.delegate = self
        viewModel.setup()
    }
    
    private func setupNavItems() {
        self.navigationItem.title = "Search"
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                           target: self,
                                           action: #selector(searchTapped))
        self.navigationItem.rightBarButtonItem = searchButton
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount()
    }
    
    func fetchItemsCompleted() {
        tableView.reloadData()
        print(tableView.visibleCells.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubRedditTableViewCell.reuseIdentifier, for: indexPath)
        if let subRedditCell = cell as? SubRedditTableViewCell {
            let subRedditItem = viewModel.getSubRedditItemForRow(indexPath: indexPath)
            subRedditCell.titleLabel?.text = subRedditItem?.title
            subRedditCell.subredditLabel?.text = subRedditItem?.subreddit
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let subRedditItem = viewModel.getSubRedditItemForRow(indexPath: indexPath)
        guard let url = subRedditItem?.url else { return }
        let webViewController = RedditWebViewController()
        webViewController.url = url
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        presentSearchAlert()
    }
    
    private func presentSearchAlert() {
        let searchAlertController = UIAlertController(title: "Subreddits",
                                                      message: "What do you want to find?",
                                                      preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        searchAlertController.addAction(cancel)
        
        let nextAction = UIAlertAction(title: "Search", style: .default) {[weak self] action -> Void in
            self?.performSearch(string: searchAlertController.textFields?.first?.text)
        }
        searchAlertController.addAction(nextAction)

        searchAlertController.addTextField(configurationHandler: nil)
        present(searchAlertController, animated: true, completion: nil)
    }
    
    private func performSearch(string: String?) {
        viewModel.search(searchString: string)
    }
    
    
    // MARK: - Search bar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        sendSearchToViewModel(text: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sendSearchToViewModel(text: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.clearFilter()
    }
    
    private func sendSearchToViewModel(text: String?) {
        if text == "" {
            viewModel.clearFilter()
            return
        }
        viewModel.filter(filterString: text)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
