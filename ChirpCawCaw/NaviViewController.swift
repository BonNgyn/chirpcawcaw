//
//  NaviViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 7/1/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class NaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavIcon()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavIcon(){
        let image = UIImage(named: "not-liked.png")
        self.navigationItem.titleView = UIImageView(image: image)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
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
