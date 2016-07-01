//
//  ProfileViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 7/1/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var profileDescriptionLabel: UILabel!
    @IBOutlet weak var profileScreenNameLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileBackgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserImage() -> UIImage {
        let url = user?.profileUrl
        var image: UIImage = UIImage(named: "no_profileImage.jpeg")!
        let imageBool = user?.profileImageBool!
        
        if !imageBool! {
            if let data = NSData(contentsOfURL: url!) {
                image = UIImage(data:data)!
                
            }
        }
        return image
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
