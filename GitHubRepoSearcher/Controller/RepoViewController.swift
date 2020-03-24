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

class RepoViewController: UIViewController {
    @IBOutlet var repoNameLabel: UILabel!
    @IBOutlet var repoDescLabel: UILabel!
    @IBOutlet var ownerNameLabel: UILabel!
    @IBOutlet var ownerEmailLabel: UILabel!
    
    var repoName: String?
    var repoDesc: String?

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
        
        var counter = 0
        
        if favoriteRep.count != 0 {
            for elem in 0...(favoriteRep.count - 1) {
                if favoriteRep[elem].name == self.repoNameLabel.text {
                    counter += 1
                }
            }
            
            if counter != 0 {
                print("Already in favorite")
            } else {
                favoriteRep.append(Repos(name: self.repoNameLabel.text, description: self.repoDescLabel.text, ownerName: self.ownerNameLabel.text, ownerEmail: self.ownerEmailLabel.text))
            }
        }
        
        
        
        saveToJsonFile()
    }
    
    func saveToJsonFile() {
        do {
            var favArray: [AnyObject] = []
            for elem in favoriteRep {
                var repoDict: [String: AnyObject] = [:]
                repoDict["name"] = elem.name as AnyObject?
                repoDict["description"] = elem.description as AnyObject?
                repoDict["ownerName"] = elem.ownerName as AnyObject?
                repoDict["ownerEmail"] = elem.ownerEmail as AnyObject?
                favArray.append(repoDict as AnyObject)
            }
            let jsonData = try JSONSerialization.data(withJSONObject: favArray, options: .prettyPrinted)
            let fileManager = FileManager.default
            let url = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let jsonUrl = url.appendingPathComponent("file.json")
            print(jsonUrl)
            try jsonData.write(to: jsonUrl)
        } catch  {
            print(error)
        }
    }
    
}
