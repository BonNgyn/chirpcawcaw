//
//  ProfileViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 7/1/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileDescriptionLabel: UILabel!
    @IBOutlet weak var profileScreenNameLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var profileBackgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileDescriptionLabel.text = User._currentUser?.tagline as? String
        profileScreenNameLabel.text = User._currentUser?.screenname as? String
        profileUsernameLabel.text = User._currentUser?.name as? String
        profileImage.setImageWithURL((User._currentUser?.profileUrl)!)
        followingCount.text = "\(User._currentUser?.followingCount)"
        followersCount.text = "\(User._currentUser?.followerCount)"
        tweetsCount.text = "\(User._currentUser?.tweetsCount)"
        
//        profileBackgroundImage.setImageWithURL((User._currentUser?.profileBackgroundUrl)!)
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        refreshData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myProfileTweetCell", forIndexPath: indexPath) as! profileTweetCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    func refreshData() {
        TwitterClient.sharedInstance.userTimeLine(User._currentUser?.screenname as! String, userID: (User._currentUser?.userId)!,success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: NSError) in
            print(error.localizedDescription)
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
