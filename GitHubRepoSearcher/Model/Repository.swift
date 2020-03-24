//
//  Repository.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: Mappable{
    
    var fullName: String?
    var description: String?
    //var owner: Owner?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        fullName <- map["full_name"]
        description <- map["description"]
        //owner <- map["owner"]
    }
}
