//
//  TweetCell.swift
//  Twitter
//
//  Created by Jonathan Schapiro on 10/9/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userFullName: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
   
    
    @IBOutlet weak var tweetTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
