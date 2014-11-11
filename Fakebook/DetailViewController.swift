//
//  DetailViewController.swift
//  Fakebook
//
//  Created by Eric Eriksson on 10/16/14.
//  Copyright (c) 2014 Eric Eriksson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var commentImg: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var detailView: UIImageView!
    @IBOutlet weak var detailScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "kbShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "kbHidden:", name: UIKeyboardWillHideNotification, object: nil)
        

                detailScrollView.contentSize = CGSize(width: 320, height: detailView.frame.size.height)
    }
    
    func kbShown(notification: NSNotification) {
        UIView.animateWithDuration(0.3, animations: {
            self.commentImg.frame.origin.y = 300
            self.commentTextField.frame.origin.y = 308
        })
    }
    
    func kbHidden(notification: NSNotification) {
        UIView.animateWithDuration(0.3, animations: {
            self.commentImg.frame.origin.y = 475
            self.commentTextField.frame.origin.y = 482
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLikeButton(sender: AnyObject) {
        if likeButton.selected == true {
            likeButton.selected = false
        } else {
            likeButton.selected = true
        }
    }

    @IBAction func onTapDismiss(sender: AnyObject) {
        view.endEditing(true)
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
