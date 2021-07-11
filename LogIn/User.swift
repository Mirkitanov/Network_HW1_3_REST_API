//
//  User.swift
//  Navigation
//
//  Created by Админ on 04.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var login: String
    var password: String
    var isCurrentUser: Bool?
    
    init(id: String, login: String, password: String, isCurrentUser: Bool) {
        self.id = id
        self.login = login
        self.password = password
        self.isCurrentUser = isCurrentUser
    }
}
