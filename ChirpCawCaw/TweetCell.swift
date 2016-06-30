//
//  TweetCell.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 6/29/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var tweet: Tweet?

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getTweet(tweet: Tweet) {
        self.userImage.setImageWithURL((tweet.user?.profileUrl)!)
        self.usernameLabel.text = tweet.user?.name as? String
        self.screenNameLabel.text = "@" + ((tweet.user?.screenname)! as String)
        self.tweetLabel.text = tweet.text as? String
        
        self.tweet = tweet
    }
}
