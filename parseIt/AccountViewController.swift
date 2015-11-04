//
//  AccountViewController.swift
//  parseIt
//
//  Created by Sebastian Drew on 11/2/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class AccountViewController: UIViewController {
    
    var usernames = [""]
    var userids = [""]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    
        var query = PFUser.query()
        
        
            query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                // ..
                
                if let users = objects {
                 
                    
                    self.usernames.removeAll(keepCapacity: true)
                    self.userids.removeAll(keepCapacity: true)
                    
                    for object in users {
                        
                        if let user = object as? PFUser {
                            
                            if user.objectId != PFUser.currentUser()?.objectId {
                            
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    
                }
                
                print(self.usernames)
                print(self.userids)
                
                
            })
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
