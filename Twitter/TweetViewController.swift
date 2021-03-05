//
//  TweetViewController.swift
//  Twitter
//
//  Created by Aryan Choudhary on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetTextCount: UILabel!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        tweetTextView.layer.cornerRadius = 15
        tweetTextView.layer.borderWidth = 0.1
        tweetButton.isEnabled = false
        tweetButton.tintColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        let textCount = characterLimit - newText.count
        tweetTextCount.text = "\(textCount) characters remaining..."
        
        if (textCount != 280) {
            tweetButton.isEnabled = true
            tweetButton.tintColor = UIColor.white
        } else {
            tweetButton.isEnabled = false
            tweetButton.tintColor = UIColor.black
        }
        
        return textCount > 0
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            return
//            self.dismiss(animated: true, completion: nil)
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
