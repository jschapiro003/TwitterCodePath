//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Jonathan Schapiro on 10/11/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    
    var screenameFullName:String = "nil"
    var screennameUsername:String = "nil"
    var profilePictureURL:String = "nil"
    var tweetText:String?
    var status: NSDictionary?
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
   
 
   
    @IBOutlet weak var tweetTextField: UITextView!
   
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var twitterUsernameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let currentUser = User.currentUser?.name?{
            screenameFullName = currentUser
            usernameLabel.text = screenameFullName
        }
        
        if let currentUserScreenname = User.currentUser?.screenname?{
            var atSign = "@"
            
            screennameUsername = currentUserScreenname
            atSign += screennameUsername
            twitterUsernameLabel.text = atSign
        }
        
        if let profilePicURL = User.currentUser?.profileImageUrl?{
            profilePictureImageView.setImageWithURL(NSURL(string: profilePicURL))
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func composeTweet(sender: AnyObject) {
        
        tweetText = tweetTextField.text
        println("tweetText: \(tweetText)")
        
       
        
        if let urlEncodedString = tweetText?{
            
            status = ["status": urlEncodedString]
            if let parameters = status?{
            TwitterClient.sharedInstance.postStatus(parameters)
            }
        }
        
        tweetTextField.text = "Post a New Tweet"
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
