//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Jonathan Schapiro on 10/8/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var hud = MBProgressHUD(view: self.view)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        println("loading")
        
        println("loading")
        hud.labelText = "LOADING"
        self.tableView.addSubview(hud)
         hud.show(true)
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            
           
           
            
           
            self.tweets = tweets
         
            self.tableView.reloadData()
            
            
        })
       
        self.tableView.reloadData()
        hud.hide(true)
        hud.removeFromSuperview()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if let tweetCount = self.tweets{
           
            return tweetCount.count
            
        }else{
            
            return 12
        }
        
      
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showTweet"){
          let index = tableView!.indexPathForSelectedRow()!.row
            let detailViewController: TweetsDetailViewController = segue.destinationViewController as TweetsDetailViewController
            
            if let fullName = self.tweets{
                
                
                //NEXT TIME USE if let to safely unwwrap these optionals
                
                detailViewController.screenameFullName = fullName[index].user!.name!
                var atSign = "@"
                atSign += fullName[index].user!.screenname!
                detailViewController.screennameUsername = atSign
                detailViewController.screennameTextBody = fullName[index].text!
                detailViewController.tempImageUrl = fullName[index].user!.profileImageUrl!
                
                if let favoriteCount = fullName[index].user?.favorites?{
                detailViewController.screenNameFavorites = String(favoriteCount)
                }
                
                
           

            }

        }
    }
  
    
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tweetCell") as TweetCell
        
        if let tweetCellText = self.tweets{
            
            cell.tweetText.text = tweetCellText[indexPath.row].text
            cell.userFullName.text = tweetCellText[indexPath.row].user!.name
            var atSign = "@"
            atSign += tweetCellText[indexPath.row].user!.screenname!
            cell.userName.text = atSign
            cell.userImage.setImageWithURL(NSURL(string: tweetCellText[indexPath.row].user!.profileImageUrl!))
           cell.userImage.contentMode = UIViewContentMode.TopLeft

        }else{
      
            
        }

                return cell
    }
    
    
  
    
    
    @IBAction func makeNewTweet(sender: AnyObject) {
        println("hello world")
        //performSegueWithIdentifier("createNewTweet", sender: sender)
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
