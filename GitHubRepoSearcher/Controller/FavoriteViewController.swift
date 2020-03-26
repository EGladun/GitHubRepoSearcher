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
import RealmSwift

class FavoriteViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var nib = UINib(nibName: "TableViewCell", bundle: nil)
    var favoriteRep: Results<RepositoryRealmModel>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "favorite"
        self.tableView.register(nib, forCellReuseIdentifier: "MyCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.favoriteRep = realm.objects(RepositoryRealmModel.self)
    }


}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.favoriteRep.count != 0 {
            return self.favoriteRep.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        let item = self.favoriteRep[indexPath.row]
        cell.awakeFromNib(name: item.name)
        return cell
    }
    
    
}

