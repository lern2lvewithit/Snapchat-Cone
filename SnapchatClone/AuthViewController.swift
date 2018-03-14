//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Steven Lerner on 3/10/18.
//  Copyright © 2018 Steven Lerner. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var loginMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func topTapped(_ sender: Any) {
        
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if loginMode {
                    // Login
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                        }
                    })
                } else {
                    // Sign UP
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            if let user = user {  Database.database().reference().child("users").child(user.uid).child("email").setValue(email)
                                self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                            }
                        }
                    })
                }
            }
        }
        
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if loginMode {
            // Switch to Sign Up
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch To Login", for: .normal)
            loginMode = false
        } else {
            // Switch to Login
            topButton.setTitle("Login", for: .normal)
            bottomButton.setTitle("Switch To Sign Up", for: .normal)
            loginMode = true
        }
    }
    
    
}

