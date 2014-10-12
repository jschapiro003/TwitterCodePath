//
//  TwitterClient.swift
//  Twitter
//
//  Created by Jonathan Schapiro on 10/6/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

let twitterConsumerKey = "99Ugq7xlqZ6yhqTfXbW6A22HC"
let twitterConsumerSecret = "foWoL8bJyTj5WVhTRCz6QITX01KhKu1YJgkRJzVtxUdVXcXkLA"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
   
    class var sharedInstance: TwitterClient {
        struct Static{
            static let instance =  TwitterClient(baseURL: twitterBaseURL, consumerKey:twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams (params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
       GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        
        
           
        
        
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
        
        
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error getting tweets")
                completion(tweets: nil, error: error)
                
                
        })
        
    }
    
    func loginWithCompletion (completion: (user: User?, error: NSError?) -> () ){
        loginCompletion = completion
        
        // fetch my request token and redirect to auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            
            
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            
            UIApplication.sharedApplication().openURL(authURL!)
            
            println ("Got the request token")
            
            
            }) { (error: NSError!) -> Void in
                println("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func postStatus(status: NSDictionary?){
        POST("1.1/statuses/update.json", parameters: status, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("status post: \(response as NSDictionary)")
        
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error getting tweets")
                
                
                
        })

    }
    
    
    func openURL(url: NSURL){
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            
            
            
            //make a request from the end point verify_requentials (found on twitters api site)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
              
                var user = User(dictionary: response as NSDictionary)
                //after successfully serializing the data
                User.currentUser = user
                println("user: \(user.name)")
                
                    
            
               
                
                
                self.loginCompletion?(user: user, error: nil)
                
                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error getting credentials")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            
            
            
         
            
           
            
            
            
            
            }) { (error: NSError!) -> Void in
                
                println("Failed to receive access token!")
                 self.loginCompletion?(user: nil, error: error)
        }

    }
    
}
