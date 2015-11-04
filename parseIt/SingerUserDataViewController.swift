//
//  SingerUserDataViewController.swift
//  Pods
//
//  Created by Sebastian Drew on 11/2/15.
//
//

import UIKit
import Parse

class SingerUserDataViewController: UIViewController {
    


    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var bloodtypeField: UITextField!
    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var user = PFUser.currentUser()
    
    // Add to Simple
    var simply = PFObject(className: "Simple")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        

    }
    
    
    
    @IBAction func submitButtonDidTouch(sender: UIButton) {
        
        simply["firstname"] = firstnameField.text
        simply["lastname"] = lastnameField.text
        simply["bloodtype"] = bloodtypeField.text
        simply["user"] = PFUser.currentUser()?.objectId
        
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center.y = 100
        activityIndicator.center.x = self.view.center.x
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()

        
        simply.saveInBackgroundWithBlock { (success, error) -> Void in
            
                       
            if success == true {
                 self.activityIndicator.stopAnimating()
                 UIApplication.sharedApplication().endIgnoringInteractionEvents()
                 self.performSegueWithIdentifier("successSegue", sender: self)
                print("Success!")
            } else {
                print("Failed")
                 self.activityIndicator.stopAnimating()
                print(error)
            }
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
