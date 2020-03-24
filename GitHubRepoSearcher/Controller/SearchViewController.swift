//
//  SearchViewController.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var parser = Parser()

    var repoArray:[Repo] = []
    var nib = UINib(nibName: "TableViewCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.createSearchBar()
        self.tableView.register(nib, forCellReuseIdentifier: "MyCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

}

//MARK: - TableView extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        cell.awakeFromNib(name: self.repoArray[indexPath.row].fullName!)
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = RepoViewController()
        nextVC.repoName = self.repoArray[indexPath.row].fullName
        nextVC.repoDesc = self.repoArray[indexPath.row].description
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}

//MARK: - SearchBar extension
extension SearchViewController: UISearchBarDelegate {
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter text..."
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        
        self.navigationItem.titleView = searchBar
    }
    
    //Hide keybord when cancelButton tapped
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("tap")
        if let searchBar = self.navigationItem.titleView {
            searchBar.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.parser.doRequest(args: searchBar.text!, completion: {
            self.repoArray = self.parser.repo
            self.tableView.reloadData()
        })
        if let searchBar = self.navigationItem.titleView {
            searchBar.endEditing(true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
