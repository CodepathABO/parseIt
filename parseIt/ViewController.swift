//
//  ViewController.swift
//  parseIt
//
//  Created by Sebastian Drew on 11/2/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse


// SIMPLE SIGNUP FOR PARSE

class ViewController: UIViewController {
    
    var signupActive = true

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var alreadyRegisteredLabel: UILabel!
    @IBOutlet weak var signIn: UIButton!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       signupButton.layer.cornerRadius = 20
        
        signInButton.hidden = true
        
    }
    
    /*
    Signup button connects to parse to add data to the "SIMPLE" table.
    it switches the button text from signup to login... just for fun
    
    on login you are sent to your "account page" on signup you are sent
    to a for m to fill in first name, last name, and blood type fields.
    
    This writes to Parse database which then send you to your user account page
    where your fields are displated.
    
    The Flow: 
    1. View Controller (Signup/Log In)
    2. If sign up - SingerUserDataViewController (TYPO I KNOW)
    3. UserInfoViewController (Account page)
    4. Edit page
    
    Basic. but gets the into in and out of parse. and updated.

    */
    
    @IBAction func signUpButtonDidTouch(sender: UIButton) {
        
        if usernameField.text == "" || passwordField.text == "" {
         
        displayAlert("Login Error", message: "One or more required fields have been left blank")
            
        } else {
            
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicator.center.y = 100
            activityIndicator.center.x = self.view.center.x
            
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
        
            var errorMessage = "Please try again later"
            
            if signupActive == true {
            
            
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text

        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if let error = error {
                let errorString = error.userInfo["error"] as? String
                
                
                print("error")
                
                errorMessage = errorString!
                
                self.displayAlert("Failed signup", message: errorMessage)
                
            } else {
                // Hooray! Let them use the app now.

                self.performSegueWithIdentifier("parseit", sender: self)
            }
        
            }
            
            } else {
                
                
                
                PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
                    (user: PFUser?, error: NSError?) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        // Do stuff after successful login.

                        self.performSegueWithIdentifier("loggedInSegue", sender: self)
                        print("YAY!")
                    
                    } else {

                        // The login failed. Check error to see why.
                        
                        if let error = error {
                            let errorString = error.userInfo["error"] as? String
                            
                            
                            print("error")
                            
                            errorMessage = errorString!
                            
                            self.displayAlert("Failed Login", message: errorMessage)
                            
                        }
                        
                    }
                }

            }
        }
        
    }
    

    @IBAction func signInSwapButton(sender: UIButton) {
        
        if signupActive == true {
            
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            
            alreadyRegisteredLabel.text = "Not registered?"
            
            signIn.setTitle("Sign In", forState: UIControlState.Normal)
            
            signupActive = false
            
        } else {
            
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            alreadyRegisteredLabel.text = "Already registered?"
            
            signIn.setTitle("Log In", forState: UIControlState.Normal)
            
            signupActive = true

            
        }
    }
    
    
    @IBAction func signInButtonDidTouch(sender: UIButton) {
        
        
            
            
            PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    self.activityIndicator.stopAnimating()
                    // UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.performSegueWithIdentifier("parseit", sender: self)
                    print("YAY!")
                } else {
                    self.activityIndicator.stopAnimating()
                    // UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    // The login failed. Check error to see why.
                    
                    
            }
        }
        
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

