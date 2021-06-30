//
//  Checker.swift
//  Navigation
//
//  Created by Админ on 19.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

/// Class for login and password checking
class Checker {
    let login = "Pavel@mail.ru"
    let password = "123"
    
    static let shared: Checker = {
        let checker = Checker()
        return checker
    }()
    
    //MARK: - Init
    private init() {}
    
    func check(userLogin: String?, userPass: String?) -> Bool {
        if userLogin == login || userPass == password {
            return true
        }
        return false
    }
}

