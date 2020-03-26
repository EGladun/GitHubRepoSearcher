//
//  RepositoryRealmModel.swift
//  GitHubRepoSearcher
//
//  Created by Egor on 26.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import RealmSwift

class RepositoryRealmModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var descriptionRep = ""
    @objc dynamic var ownerName = ""
    @objc dynamic var ownerEmail = ""
}
