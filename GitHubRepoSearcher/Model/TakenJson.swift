//
//  TakenJson.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 23.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import ObjectMapper

class TakenJson: Mappable {
    
    var items: [Repository] = []
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
    
    
    
}
