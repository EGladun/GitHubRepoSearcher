//
//  RepoViewController.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift

class RepoViewController: UIViewController {
    @IBOutlet var repoNameLabel: UILabel!
    @IBOutlet var repoDescLabel: UILabel!
    @IBOutlet var ownerNameLabel: UILabel!
    @IBOutlet var ownerEmailLabel: UILabel!
    
    var repoName: String?
    var repoDesc: String?
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.repoName ?? "Unknown name"
        self.repoNameLabel.text = (self.repoName ?? "Error")
        self.repoDescLabel.text = (self.repoDesc ?? "Error")
        self.requestEmail()
    }
    
    func requestEmail(){
        let ownerName = self.repoName?.components(separatedBy: "/")[0]
        self.ownerNameLabel.text = (ownerName ?? "Error")
        Alamofire.request("https://api.github.com/users/\(ownerName!)").validate().responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success(let value):
                self.ownerEmailLabel.text = (value.email ?? "Hidden")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func addClicked(_ sender: Any) {
        
        let currentRepo = RepositoryRealmModel()
        currentRepo.name = self.repoNameLabel.text!
        currentRepo.descriptionRep = self.repoDescLabel.text!
        currentRepo.ownerName = self.ownerNameLabel.text!
        currentRepo.ownerEmail = self.ownerEmailLabel.text!
        
        try! realm.write {
            realm.add(currentRepo)
        }
    }
}
