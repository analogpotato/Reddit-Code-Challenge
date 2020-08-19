//
//  SubredditListViewTableViewController.swift
//  Reddit Code Challenge
//
//  Created by Frank Foster on 8/18/20.
//  Copyright © 2020 Frank Foster. All rights reserved.
//

import UIKit

class SubredditListViewTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var list = [Post]()
    
    let homeURL = "https://www.reddit.com/.json"
    let refresh = UIRefreshControl()
    var refreshString = "https://www.reddit.com/.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        loadData(url: homeURL)
        
    }
    
    
    func configureView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Subreddits"
        navigationItem.searchController = search
        
        tableView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "Fetching new data...")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goHome))
    }
    
    
    func loadData(url: String) {
        let url = url
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(Model.self, from: data)
                        self.list = jsonData.data.children
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        print(error)
                    }
                    
                }
                
            }.resume()
            
        }
        
    }
    
    @objc
    func goHome() {
        loadData(url: homeURL)
    }
    
    func searchSubreddit(urlString: String) {
        let searchString = "https://www.reddit.com/r/\(urlString)/.json"
        loadData(url: searchString)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchSubreddit(urlString: text)
        refreshString = text
    }
    
    @objc
    func refreshData() {
        loadData(url: refreshString)
        DispatchQueue.main.async {
            self.refresh.endRefreshing()
        }
    }
    
    
    // MARK: - Table view data source
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListViewCell else {
            fatalError("Cannot create cell")
        }
        
        //        print("cells loaded")
        let posts = list[indexPath.row]
        cell.postTitle.text = posts.data.title
        cell.postSubreddit.text = posts.data.subreddit
        cell.postVoteCount.text = "\(posts.data.score)"
        cell.postURL.text = "\(posts.data.url)"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell # \(indexPath.row)!")
        
        let indexPath = tableView.indexPathForSelectedRow!
        let posts = list[indexPath.row]
        
        print ("\(posts.data.url)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            if let detailVC = segue.destination as? DetailView {
                let indexPath = tableView.indexPathForSelectedRow!
                let posts = list[indexPath.row]
                detailVC.urlString = "\(posts.data.url)"
            }
        }
    }
    
    
}
