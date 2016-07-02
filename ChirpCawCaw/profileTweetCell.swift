//
//  profileTweetCell.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 7/1/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class profileTweetCell: UITableViewCell {
    
    
    var tweetId: String!

    @IBOutlet weak var profileLikeCount: UILabel!
    @IBOutlet weak var profileRetweetCount: UILabel!
    @IBOutlet weak var profileUserImage: UIImageView!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileScreenNameLabel: UILabel!
    @IBOutlet weak var profileTweetLabel: UILabel!
    @IBOutlet weak var profileTimestampLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            self.profileUserImage.setImageWithURL((tweet!.user?.profileUrl)!)
            self.profileUsernameLabel.text = tweet!.user?.name as? String
            self.profileScreenNameLabel.text = "@" + ((tweet!.user?.screenname)! as String)
            self.profileTweetLabel.text = tweet!.text as? String
            self.profileTimestampLabel.text = tweet!.timestamp?.shortTimeAgoSinceNow()
            self.profileRetweetCount.text = "\(tweet!.retweetCount)"
            self.profileLikeCount.text = "\(tweet!.favoritesCount)"
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
