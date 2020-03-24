//
//  ViewController.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        self.title = "Main"
        
        openJson()
        
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        let nextViewController = SearchViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let nextViewController = FavoriteViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func openJson() {
        do {
            let fileManager = FileManager.default
            let url = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let jsonUrl = url.appendingPathComponent("file.json")
            print(jsonUrl)
            let jsonReadData = try Data(contentsOf: jsonUrl)
            
            let parsedData = try JSONSerialization.jsonObject(with: jsonReadData, options: .mutableContainers)
            
            let datas = parsedData as! [[String: AnyObject]]
            
            for data in datas {
                guard let name = data["name"] as? String, let description = data["description"] as? String, let ownerName = data["ownerName"] as? String, let ownerEmail = data["ownerEmail"] as? String else {continue}
                let currentRepo = Repos(name: name, description: description, ownerName: ownerName, ownerEmail: ownerEmail)
                favoriteRep.append(currentRepo)
            }
            
        } catch {
            print(error)
        }
        
        for data in favoriteRep {
            print(data)
        }
    }
}

