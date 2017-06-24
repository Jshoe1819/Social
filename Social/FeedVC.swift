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

class FeedVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts = []
        
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
          self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print("JAKE: \(post.caption)")
        
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }

    @IBAction func signOutTapped(_ sender: UIButton) {
        
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("JAKE: ID removed from keychain: \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
