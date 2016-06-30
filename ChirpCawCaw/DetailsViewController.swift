//
//  DetailsViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 6/30/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var userImageSegue: UIImage!
    var userNameSegue: String!
    var screenNameSegue: String!
    var timestampSegue: String!
    var tweetSegue: String!

    @IBOutlet weak var detailUserImage: UIImageView!
    @IBOutlet weak var detailUsername: UILabel!
    @IBOutlet weak var detailScreenName: UILabel!
    @IBOutlet weak var detailTimestamp: UILabel!
    @IBOutlet weak var detailTweet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailUsername.text = userNameSegue
        detailUserImage.image = userImageSegue
        detailScreenName.text = screenNameSegue
        detailTimestamp.text = timestampSegue
        detailTweet.text = tweetSegue

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToHome", sender: self)
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
