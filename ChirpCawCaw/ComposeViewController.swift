//
//  ComposeViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 7/1/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var user: User?

    
    @IBOutlet weak var tweetField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tweetButton(sender: AnyObject) {
        TwitterClient.sharedInstance.composeTweet(tweetField.text!) { (error) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
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
