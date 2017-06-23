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
                print("JAKE: Unable to facebook auth - \(error)")
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
                print("JAKE: unable to auth with fbase - \(error)")
            } else {
                print("JAKE: successful fbase auth")
            }
        }
    }

}

