//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Aryan Choudhary on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var userInfo = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.twitter.com/1.1/account/verify_credentials.json"
        let params = ["email": "test@gmail.com"]
        
        TwitterAPICaller.client?.getDictionaryRequest(url: url, parameters: params, success: { (user: NSDictionary) in
            self.nameLabel.text = user["name"] as? String
            self.tagLineLabel.text = user["description"] as? String
            
            if (self.tagLineLabel.text?.count == 0) {
                self.tagLineLabel.text = "No tagline!"
            }
            
            let status = user["status"] as! NSDictionary
            let followingCount = user["friends_count"] as! Int
            let followersCount = user["followers_count"] as! Int
            let tweetCount = status["retweet_count"] as! Int
            var endFollowerStr = "followers"
            var endTweetStr = "tweets ."
            
            if (followersCount == 1) {
                endFollowerStr = "follower"
            }
            
            if (tweetCount == 1) {
                endTweetStr = "tweet ."
            }
            
            self.followersLabel.text = "\(String(followersCount)) \(endFollowerStr)"
            self.tweetsLabel.text = "\(String(tweetCount)) \(endTweetStr)"
            self.followingLabel.text = "\(String(followingCount)) following ."
            
            let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)!
            let data = try? Data(contentsOf: imageURL)
            
            if let imageData = data {
                self.profileImageView.image = UIImage(data: imageData)
                self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
            }
            
        }, failure: { (error) in
            print("error getting user info: \(error)")
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
