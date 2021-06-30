//
//  LoginInspector.swift
//  Navigation
//
//  Created by Админ on 19.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject {
    func userCheck(login: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
}


class LoginInspector: LoginViewControllerDelegate {
    
    
    func userCheck(login: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        
        Auth.auth().signIn(withEmail: login, password: password, completion: completion)
    }
    
}
