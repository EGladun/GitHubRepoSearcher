//
//  Parser.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class Parser {
    
    var repo: [Repo] = []
    
    func doRequest(args: String, completion: @escaping() -> Void){
        Alamofire.request("https://api.github.com/search/repositories?q=\(args)").validate().responseObject { (response: DataResponse<TakenJson>) in
            switch response.result {
            case .success(let value):
                let takenJson = TakenJson()
                takenJson.items = value.items
                takenJson.items.forEach({ (arg0) in
                   self.repo.append(Repo(fullName: arg0.fullName, description: arg0.description))
                })
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}

struct Repo {
    var fullName: String?
    var description: String?
}
