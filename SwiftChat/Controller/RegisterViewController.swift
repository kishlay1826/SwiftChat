//
//  ViewController.swift
//  SwiftChat
//
//  Created by Kishlay Chhajer on 2020-08-18.
//  Copyright © 2020 Kishlay Chhajer. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func registerButton(_ sender: UIButton) {
        if let email = emailText.text, let password = passwordText.text {
            Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
        }
    }


}

