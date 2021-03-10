//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Eshaan Lumba on 09/03/2021.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    
    var tweetArray = [NSDictionary]() // an array of dictionaries
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.displayUserInfo()
    }
    
    func displayUserInfo() {
        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
        let myParams = ["include_email": false]
        
        TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: myParams, success: { (profile: NSDictionary) in
            self.userNameLabel.text = profile["screen_name"] as? String
            self.userBioLabel.text = profile["description"] as? String
            
            
            let profileImageUrl = URL(string: (profile["profile_image_url_https"] as? String)!)
            let dataProfile = try? Data(contentsOf: profileImageUrl!)
            
            if let imageDataProfile = dataProfile {
                self.profileImageView.image = UIImage(data: imageDataProfile)
            }
            
            
            
        }, failure: { (Error) in
            print("User data could not be loaded \(Error)")
        })
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
