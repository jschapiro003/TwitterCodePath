//
//  User.swift
//  Twitter
//
//  Created by Jonathan Schapiro on 10/7/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogOutNotification = "userDidLogOutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    var favorites: Int?
    var retweets: Int?
    
    init (dictionary: NSDictionary){
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        favorites = dictionary["favourites_count"] as? Int
        
        
        
    }
    
    func logout(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogOutNotification, object: nil)
    }
    
    
    //persistence - checks to see if user has logged in before
    class var currentUser: User?{
        get{
            if _currentUser == nil{
            var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil{
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                            _currentUser = User(dictionary: dictionary)
                }
            }
                return _currentUser
        }
        set(user){
            _currentUser = user
            if _currentUser != nil{
            var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }else{
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
}
