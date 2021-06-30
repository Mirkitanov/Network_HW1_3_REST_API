//
//  LoginInspector.swift
//  Navigation
//
//  Created by Админ on 19.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
class LoginInspector: LoginViewControllerDelegate {
    /// Function of login checking
    func checkLogin(_ login: String) -> Bool {
        guard login.uppercased() == Checker.shared.login.uppercased() else {
            return false
        }
        
        return true
    }
    
    /// Function of password checking
    func checkPassword(_ password: String) -> Bool {
        guard password == Checker.shared.password else {
            return false
        }
        
        return true
    }
}
