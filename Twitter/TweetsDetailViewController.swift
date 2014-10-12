//
//  TweetsDetailViewController.swift
//  Twitter
//
//  Created by Jonathan Schapiro on 10/9/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {
    
    
    var screenameFullName:String = "nil"
    var screennameUsername:String = "nil"
    var screennameTextBody:String = "nil"
    var imageURL:String = "nil"
    var tempImageUrl:String = "nil"
    var secreenNameRetweets:String = "nil"
    var screenNameFavorites = "nil"
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var retweetsLabel: UILabel!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userFullName: UILabel!
    
    @IBOutlet weak var userUserName: UILabel!

    @IBOutlet weak var userTextBody: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.userFullName.text = self.screenameFullName
        self.userUserName.text = self.screennameUsername
        self.userTextBody.text = self.screennameTextBody
        self.favoritesLabel.text = self.screenNameFavorites
        
        self.userProfileImage.setImageWithURL(NSURL(string: tempImageUrl))
            
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
