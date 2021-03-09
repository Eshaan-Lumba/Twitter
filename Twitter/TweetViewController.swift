//
//  TweetViewController.swift
//  Twitter
//
//  Created by Eshaan Lumba on 09/03/2021.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charsLeftLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        
        charsLeftLabel.text = "140"
    }
    
    func checkRemainingChars() {
        let allowedChars = 180
        let charsInTextView = -tweetTextView.text.count
        
        let remainingChars = allowedChars + charsInTextView
        
        if remainingChars <= allowedChars {
            charsLeftLabel.textColor = UIColor.black
        }
        
        if remainingChars <= 20 {
            charsLeftLabel.textColor = UIColor.orange
        }
        
        if remainingChars <= 10 {
            charsLeftLabel.textColor = UIColor.red
        }
        
        charsLeftLabel.text = String(remainingChars)
    }

    func textViewDidChange(_ textView: UITextView) {
        checkRemainingChars()
    }

    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        let allowedChars = 180
        let charsInTextView = -tweetTextView.text.count
        
        let remainingChars = allowedChars + charsInTextView
        if remainingChars < 0 {
            let alert = UIAlertController(title: "Too many characters in tweet!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if (!tweetTextView.text.isEmpty ) {
                TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                    self.dismiss(animated: true, completion: nil)
                }, failure: { (error) in
                    print("Error posting tweet \(error)")
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
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
