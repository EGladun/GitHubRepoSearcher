//
//  Owner.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Owner: Mappable {
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
    }
    
    var name: String?
    var email: String?
    
    func requestEmail(name: String) {
        Alamofire.request("https://api.github.com/search/users?q=\(name)").validate().responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}

