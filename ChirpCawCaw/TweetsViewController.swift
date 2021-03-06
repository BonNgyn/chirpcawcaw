//
//  TweetsViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 6/29/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit
import DateTools
import AFDateHelper

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        refreshData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myTweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        
        cell.touchButton.tag = indexPath.row
        cell.tweet = tweet
        
        
        
        return cell
    }
    
    func refreshData() {
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) in
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
    
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let vc = segue.destinationViewController as! DetailsViewController
            if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                let tweet = self.tweets[indexPath.row]
                
                vc.userNameSegue = tweet.user?.name as? String
                vc.screenNameSegue = "@\(tweet.user?.screenname as! String)"
                vc.tweetSegue = tweet.text as? String
                
                let url = tweet.user?.profileUrl
                var image: UIImage = UIImage(named: "no_profileImage.jpeg")!
                let imageBool = tweet.user?.profileImageBool!
                
                if !imageBool! {
                    if let data = NSData(contentsOfURL: url!) {
                        image = UIImage(data:data)!
                        
                    }
                }
                
                vc.userImageSegue = image
                vc.timestampSegue = tweet.timestamp?.toString(format: .Custom("MM/dd/yy, H:mm a"))
                vc.retweetCountSegue = "\(tweet.retweetCount)"
                vc.likeCountSegue = "\(tweet.favoritesCount)"
            }
        } else if segue.identifier == "imageToUserSegue" {
            let vc = segue.destinationViewController as! UsersViewController
            let b = sender as! UIButton
            let c = b.superview?.superview as! UITableViewCell
            if let indexPath = self.tableView.indexPathForCell(c) {
                let user = tweets[indexPath.row].user
                vc.user = user
        }
        
        
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if let identifier = segue.identifier {
    //            switch identifier {
    //            case "detailSegue":
    //                let vc = segue.destinationViewController as! DetailsViewController
    //                if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
    //                    let tweet = self.tweets[indexPath.row]
    //
    //                    vc.userNameSegue = tweet.user?.name as? String
    //                    vc.screenNameSegue = "@\(tweet.user?.screenname as! String)"
    //                    vc.tweetSegue = tweet.text as? String
    //                    vc.userImageSegue = getUserImage(tweet)
    //                    vc.timestampSegue = tweet.timestamp?.toString(format: .Custom("MM/dd/yy, H:mm a"))
    //                    vc.retweetCountSegue = "\(tweet.retweetCount)"
    //                    vc.likeCountSegue = "\(tweet.favoritesCount)"
    //                }
    //            default: break
    //            }
    //        }
    //    }
    
    func getUserImage(tweet: Tweet) -> UIImage {
        let url = tweet.user?.profileUrl
        var image: UIImage = UIImage(named: "no_profileImage.jpeg")!
        let imageBool = tweet.user?.profileImageBool!
        
        if !imageBool! {
            if let data = NSData(contentsOfURL: url!) {
                image = UIImage(data:data)!
                
            }
        }
        return image
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
}
