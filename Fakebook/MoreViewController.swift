//
//  MoreViewController.swift
//  Fakebook
//
//  Created by Eric Eriksson on 10/16/14.
//  Copyright (c) 2014 Eric Eriksson. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UIActionSheetDelegate {

    @IBOutlet weak var settingScrollView: UIScrollView!
    @IBOutlet weak var settingsContent: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingScrollView.contentSize = CGSize(width: 320, height: settingsContent.frame.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButton(sender: AnyObject) {
        
        var actionSheet = UIActionSheet(title: "Log Out", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Log Out")
        actionSheet.showInView(view)
    }

    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == 0){
            performSegueWithIdentifier("settingsToLoggedOutSegue", sender: self)
        } else {
        
        }
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
