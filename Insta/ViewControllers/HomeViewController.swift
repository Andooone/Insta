//
//  HomeViewController.swift
//  Insta
//
//  Created by user169878 on 4/26/20.
//  Copyright © 2020 Algopedia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
        
        var post = Post(captionText: "text", photoUrlString: "url1")
    }
    
    func loadPosts(){
        FirebaseDatabase.Database.database().reference().child("posts").observe(.childAdded) {
            (snapshot:DataSnapshot) in
            print(Thread.isMainThread)
            if let dict = snapshot.value as? [String: Any]
            {
                let captionText = dict["caption"] as? String
                let photoUrlString = dict["photoUrl"] as? String
                print(captionText)
                print(photoUrlString)
                let post = Post(captionText: captionText ?? "", photoUrlString: photoUrlString ?? "")
                self.posts.append(post)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logout_TouchUpInside(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].caption
        /*var urlString = posts[indexPath.row].photoUrl
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage { return }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                cell.image = photoImage
            }
        }.resume()
        */
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
    
    
}
