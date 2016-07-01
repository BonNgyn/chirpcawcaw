//
//  profileTweetCell.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 7/1/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class profileTweetCell: UITableViewCell {

    @IBOutlet weak var profileLikeCount: UILabel!
    @IBOutlet weak var profileRetweetCount: UILabel!
    @IBOutlet weak var profileUserImage: UIImageView!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileScreenNameLabel: UILabel!
    @IBOutlet weak var profileTweetLabel: UILabel!
    @IBOutlet weak var profileTimestampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
