//
//  ViewController.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        self.title = "Main"
        
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        let nextViewController = SearchViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let nextViewController = FavoriteViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let result = try context.fetch(FavoriteRepository.fetchRequest())
            favoriteRepository = result as! [FavoriteRepository]
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}

