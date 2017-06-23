//
//  SignInVC.swift
//  Social
//
//  Created by Jacob Shoemaker on 6/21/17.
//  Copyright © 2017 Jacob Shoemaker. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("JAKE: Unable to facebook auth - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("JAKE: User cancelled facebook auth")
            } else {
                print("JAKE: Successful facebook auth")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("JAKE: unable to auth with fbase - \(String(describing: error))")
            } else {
                print("JAKE: successful fbase auth")
            }
        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("JAKE: Successful fbase email auth")
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("JAKE: Unable to email fbase auth")
                        } else {
                            print("JAKE: Successful auth with created fbase email")
                        }
                    })
                }
            })
        }
        
    }
}































