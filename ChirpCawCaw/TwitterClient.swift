//
//  TwitterClient.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 6/28/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "3FvWG8s3Fr6I7DmmrPm9HZPg3", consumerSecret: "bAPXMHwrzhYwuLzZ6gIwkHWmrfFWshmAoQY5VXGOhyEZcInYbs")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                print(error.localizedDescription)
                failure(error)
        })
    }
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "chirpcawcaw://oauth" ), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
        }) {(error: NSError!) -> Void in
            print("ERROR: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        print("User has successfully logged out")
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func retweet(id: String, success: () -> (), failure: (NSError) -> ()) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            print("Retweeted!!")
            
            success()
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
    }
    
    func like(tid: String, success: () -> (), failure: (NSError) -> ()) {
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            success()
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            failure(error)
        }
    }
    
    func composeTweet(params: NSDictionary?, completion:(error: NSError?) ->  ()) {
        POST("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            print("tweeted!")
            completion(error: nil)
            
        }) { (task: NSURLSessionDataTask?, error: NSError) in
                print(error.localizedDescription)
        }
    }
    
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
        }) {(error: NSError?) -> Void in
            print("ERROR: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
}
