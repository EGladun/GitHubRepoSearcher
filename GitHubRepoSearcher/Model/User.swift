//
//  User.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    required init?(map: Map) {
    }
    
    init(){}
    
    func mapping(map: Map) {
        email <- map["email"]
    }
    
    var email: String?
}
