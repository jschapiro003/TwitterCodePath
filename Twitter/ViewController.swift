//
//  ViewController.swift
//  Twitter
//
//  Created by Jonathan Schapiro on 10/5/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    // Button to perform the action of fetching the request token
    @IBAction func getTwitter(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil{
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{
                //handle login error
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

