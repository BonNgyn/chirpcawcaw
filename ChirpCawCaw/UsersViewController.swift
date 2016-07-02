//
//  UsersViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 7/1/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var user: User?
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var user_Description: UILabel!
    @IBOutlet weak var user_ScreenName: UILabel!
    @IBOutlet weak var user_Username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil {
            user = User._currentUser
        }
        
        user_Description.text = user!.tagline as? String
        user_ScreenName.text = user!.screenname as? String
        user_Username.text = user!.name as? String
        profileImage.setImageWithURL((user!.profileUrl)!)
        followingCount.text = "\(user!.followingCount)"
        followersCount.text = "\(user!.followerCount)"
        tweetsCount.text = "\(user!.tweetsCount)"
        
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
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myUserTableViewCell", forIndexPath: indexPath) as! UserTableViewCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    func refreshData() {
        TwitterClient.sharedInstance.userTimeLine(user!.screenname as! String, userID: (user!.userId)!,success: { (tweets: [Tweet]) in
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
