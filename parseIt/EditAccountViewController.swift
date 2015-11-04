//
//  EditAccountViewController.swift
//  parseIt
//
//  Created by Sebastian Drew on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class EditAccountViewController: UIViewController {

    @IBOutlet weak var editFirstnameField: UITextField!
    @IBOutlet weak var editLastnameField: UITextField!
    @IBOutlet weak var editBloodtypeField: UITextField!

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var user = PFUser.currentUser()
    
    var query = PFQuery(className:"Simple")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        query.whereKey("user", equalTo: (user?.objectId)!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                
                for object in objects {
                    
                    var firstname = object["firstname"] as! String
                    var lastname = object["lastname"] as! String
                    var bloodtype = object["bloodtype"] as! String
                    
                    // print(firstname)
                    
                    self.editFirstnameField.text = firstname
                    self.editLastnameField.text = lastname
                    self.editBloodtypeField.text = bloodtype

                }
                
            }
            
        }

        
        
    }
    
    @IBAction func testButton(sender: UIButton) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center.y = 100
        activityIndicator.center.x = self.view.center.x
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        
        query.whereKey("user", equalTo: (user?.objectId)!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                
                for object in objects {
                    
                    object["firstname"] = self.editFirstnameField.text
                    object["lastname"] = self.editLastnameField.text
                    object["bloodtype"] = self.editBloodtypeField.text
                    
                    // object.saveInBackground()
                    
                    
                    object.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        if success == true {
                            self.activityIndicator.stopAnimating()
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                            self.dismissViewControllerAnimated(true, completion: nil)
                            print("Success!")
                        } else {
                            print("Failed")
                            self.activityIndicator.stopAnimating()
                            print(error)
                        }
                        
                    })
                    
                }
                
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
