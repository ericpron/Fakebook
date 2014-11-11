//
//  LoginViewController.swift
//  Fakebook
//
//  Created by Eric Eriksson on 10/23/14.
//  Copyright (c) 2014 Eric Eriksson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var loginWrapperView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "kbShown:", name: UIKeyboardWillShowNotification, object: nil)
        
            loginButton.enabled = false
    }
    
    
    
    // Reveal Keyboard
    func kbShown(notification: NSNotification) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.loginWrapperView.frame.origin.y = 75
        })
        
        
    }
    
    
    @IBAction func onLoginButton(sender: AnyObject) {
        loginButton.selected = true
        self.loadingView.startAnimating()

            delay(2, { () -> () in
                self.processInput(self.emailField.text, password: self.passField.text)
            self.loadingView.stopAnimating()
        })
        
    }
    
    @IBAction func validateFields() {
        if (emailField.text == "" || passField.text == "" ) {
            loginButton.enabled = false
            println("disabled")
        } else {
            loginButton.enabled = true
            println("enabld")
        }
    }
    

    // Dismiss Keyboard
    @IBAction func dismissKeyboard(sender: AnyObject) {
        view.endEditing(true)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.loginWrapperView.frame.origin.y = 149
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func processInput(email: String, password: String) {
        var email = email.lowercaseString
        var password = password.lowercaseString
        if (email == "a" && password == "b") {
            println("correct")
            
            performSegueWithIdentifier("loginModalSegue", sender: self)
            
        } else {
            println("You Suck A Lot")
            var alertView = UIAlertView(title: "Yo", message: "You Suck", delegate: self, cancelButtonTitle: "I do")
            alertView.show()
        }
        loginButton.selected = false
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
