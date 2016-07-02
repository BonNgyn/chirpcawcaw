//
//  User.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 6/28/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var profileBackgroundUrl: NSURL?
    var tagline: NSString?
    var profileImageBool: Bool?
    var dictionary: NSDictionary?
    var userId: String?
    
    var followerCount: Int?
    var tweetsCount: Int?
    var followingCount: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetsCount = dictionary["statuses_count"] as? Int
        
        tagline = dictionary["description"] as? String
        
        profileImageBool = dictionary["default_profile_image"] as? Bool
        
//        let profileBackgroundString = dictionary["profile_background_image_url_https"] as? String
//        if let profileBackgroundString = profileBackgroundString {
//            profileBackgroundUrl = NSURL(string: profileBackgroundString)
//        }
       
        userId = dictionary["id_str"] as? String
    }
    
    static var _currentUser: User?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                
                let userData = defaults.objectForKey("currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)

                    
                }
                
            }
            
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
                
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
                
            }
            
            defaults.synchronize()
        }
    }
}
