//
//  TweetCell.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 6/29/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var tweetId: String!
    
    @IBOutlet weak var touchButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    var tweet: Tweet? {
        didSet {
            self.userImage.setImageWithURL((tweet!.user?.profileUrl)!)
            self.usernameLabel.text = tweet!.user?.name as? String
            self.screenNameLabel.text = "@" + ((tweet!.user?.screenname)! as String)
            self.tweetLabel.text = tweet!.text as? String
            self.tweetId = tweet!.id
            self.timestampLabel.text = tweet!.timestamp?.shortTimeAgoSinceNow()
            self.retweetCountLabel.text = "\(tweet!.retweetCount)"
            self.likeCountLabel.text = "\(tweet!.favoritesCount)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImage.layer.cornerRadius = 8.0;
        self.userImage.clipsToBounds = true
        
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func retweetButton(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetId, success: {
            print("RETWEET PLEASE")
        }) { (error: NSError) in
            print("ERROR: \(error)")
        }
    }
    
    @IBAction func likeButton(sender: AnyObject) {
        TwitterClient.sharedInstance.like(true, id: (tweet?.id)!,success: {
            print("LIKED")
        }) { (error: NSError) in
            print("ERROR: \(error.localizedDescription)")
        }
    }
}
