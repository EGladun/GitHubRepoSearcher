//
//  FavoriteViewController.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class FavoriteViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var nib = UINib(nibName: "TableViewCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "favorite"
        self.tableView.register(nib, forCellReuseIdentifier: "MyCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }


}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRep.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        cell.awakeFromNib(name: favoriteRep[indexPath.row].name ?? "Nothing")
        return cell
    }
    
    
}

