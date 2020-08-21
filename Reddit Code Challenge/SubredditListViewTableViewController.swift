//
//  SubredditListViewTableViewController.swift
//  Reddit Code Challenge
//
//  Created by Frank Foster on 8/18/20.
//  Copyright © 2020 Frank Foster. All rights reserved.
//

import UIKit

class SubredditListViewTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    var postList = [Post]()
    
    let homeURL = "https://www.reddit.com/.json"
    let refreshController = UIRefreshControl()
    let search = UISearchController(searchResultsController: nil)
    
    
    var refreshString = "https://www.reddit.com/.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        
        configureView()
        loadData(url: homeURL)
        
    }
 
    
    
    func configureView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Subreddits"
        navigationItem.searchController = search
        
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshController.attributedTitle = NSAttributedString(string: "Fetching new data...")
        
        let homeButton = UIButton(type: .custom)
        let homeIcon = UIImage(systemName: "house")
        homeButton.setImage(homeIcon, for: .normal)
        homeButton.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        homeButton.tintColor = UIColor.systemOrange
        let barHomeButton = UIBarButtonItem(customView: homeButton)
        
        navigationItem.rightBarButtonItem = barHomeButton
    }
    
    
    func loadData(url: String) {
        let url = url
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(Model.self, from: data)
                        self.postList = jsonData.data.children
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

    
    func searchSubreddit(urlString: String) {
        let searchString = "https://www.reddit.com/r/\(urlString)/.json"
        loadData(url: searchString)
        print("Searching this subreddit: \(searchString)")
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print("Text that will be searched \(text)")
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        refreshString = text
        searchSubreddit(urlString: text)
        print("\(refreshString)")
  }
    
    @objc
     func goHome() {
         refreshString = homeURL
         loadData(url: homeURL)
     }
    
    @objc
    func refreshData() {
        print("This is the refreshed text: \(refreshString)")
        searchSubreddit(urlString: refreshString)
        DispatchQueue.main.async {
            self.refreshController.endRefreshing()
        }
    }
    
    
    // MARK: - Table view data source
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.postList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListViewCell else {
            fatalError("Cannot create cell")
        }
        
        let posts = postList[indexPath.section]
        
//        cell.contentView.setCardView()

//        cell.contentView.layer.cornerRadius = 15
//        cell.contentView.layer.masksToBounds = true

        
        cell.postTitle.text = posts.data.title
        cell.postSubreddit.text = posts.data.subreddit
        cell.postVoteCount.text = "\(posts.data.score)"
        cell.postURL.text = "\(posts.data.url)"
        
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            if let detailVC = segue.destination as? DetailView {
                let indexPath = tableView.indexPathForSelectedRow!
                let posts = postList[indexPath.section]
                detailVC.urlString = "\(posts.data.url)"
            }
        }
    }
    
    
}

extension UIView {

    func setCardView(){
        
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = 30
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.blue.cgColor
        
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:5, height: 5)
        
        layer.masksToBounds = true
    }
}


