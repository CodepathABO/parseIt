//
//  EditItemsViewController.swift
//  parseIt
//
//  Created by Sebastian Drew on 11/2/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class EditItemsViewController: UIViewController {
    
    var usernames = [""]
    var userids = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        var account = PFObject(className: "Accounts")
            account["firstname"] = "Youboy"
            account["lastname"] = "Wilson"
            account["dob"] = "10/22/1965"
            account["email"] = "youboy@call.com"
            account["bloodtype"] = "A-"
            account["zipcode"] = 94113
            account["notifications"] = true
            account["mms"] = true
            account["texts"] = true
            account["donate"] = true
            account["request"] = false
        
        account.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success == true {
                
                print("object saved with ID \(account.objectId)")
                
            } else {
                print("failed")
                print(error)
            }
            
        }

        */
        
        
        var query = PFQuery(className: "Accounts")
        
        
        query.getObjectInBackgroundWithId("Mbw2YLkKou") { (object: PFObject?, error: NSError?) -> Void in
            
            if error
                != nil {
                    print(error)
            
            } else /* if let account = object */ {
                
//                account["firstname"] = "Benjamin"
//                account["texts"] = false
//                
//                account.saveInBackground()
                
                // print(object)
                print(object?.objectForKey("bloodtype"))
            }
        
        }
        
        
    }
    
    

    @IBAction func closeButtonDidTouch(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
