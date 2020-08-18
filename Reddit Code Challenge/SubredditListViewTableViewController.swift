//
//  SubredditListViewTableViewController.swift
//  Reddit Code Challenge
//
//  Created by Frank Foster on 8/18/20.
//  Copyright © 2020 Frank Foster. All rights reserved.
//

import UIKit

class SubredditListViewTableViewController: UITableViewController {
    
    
    var list = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadData()
        
    }
    
    
    func loadData() {
        if let url = URL(string: "https://www.reddit.com/.json") {
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
