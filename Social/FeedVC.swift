//
//  FeedVC.swift
//  Social
//
//  Created by Jacob Shoemaker on 6/23/17.
//  Copyright © 2017 Jacob Shoemaker. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signOutTapped(_ sender: UIButton) {
        
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("JAKE: ID removed from keychain: \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
